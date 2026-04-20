class InsightsController < ApplicationController
  def salary
    employees = Employee.where(country: params[:country])

    render json: {
      avg: employees.average(:salary),
      min: employees.minimum(:salary),
      max: employees.maximum(:salary)
    }
  end
end