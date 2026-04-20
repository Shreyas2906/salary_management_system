class InsightsController < ApplicationController
  before_action :require_admin

  def salary
    employees = Employee.where(country: params[:country])

    render json: {
      min: employees.minimum(:salary).to_f,
      max: employees.maximum(:salary).to_f,
      avg: employees.average(:salary).to_f
    }
  end

  def job_title
    employees = Employee.where(
      country: params[:country],
      job_title: params[:job_title]
    )

    render json: {
      avg: employees.average(:salary).to_f
    }
  end

  private

  def require_admin
    render json: { error: "Forbidden" }, status: :forbidden unless @current_user.admin?
  end
end