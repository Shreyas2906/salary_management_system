class EmployeesController < ApplicationController
  before_action :require_admin, except: [:index]
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10

    employees = Employee.includes(:user)

    if params[:search].present?
      employees = employees.where("LOWER(full_name) LIKE ?", "%#{params[:search].downcase}%")
    end

    if params[:job_title].present?
      employees = employees.where(job_title: params[:job_title])
    end

    employees = employees.offset((page - 1) * per_page).limit(per_page)

    if @current_user.admin?
      render json: employees.as_json(
        only: [:id, :full_name, :job_title, :country, :salary],
        include: { user: { only: [:email] } }
      )
    else
      render json: employees.as_json(
        only: [:id, :full_name, :job_title, :country],
        include: { user: { only: [:email] } }
      )
    end
  end

  def show
    render json: @employee
  end

  def create
    employee = Employee.create!(employee_params)
    render json: employee
  end

  def update
    @employee.update!(employee_params)
    render json: @employee
  end

  def destroy
    @employee.destroy
    render json: { message: "Deleted" }
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def employee_params
    params.permit(:full_name, :job_title, :country, :salary, :department)
  end

  def require_admin
    render json: { error: "Forbidden" }, status: :forbidden unless @current_user.admin?
  end
end