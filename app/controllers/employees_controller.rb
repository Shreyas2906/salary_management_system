class EmployeesController < ApplicationController
  before_action :require_admin
  before_action :set_employee, only: [:show, :update, :destroy]

  def index
    employees = Employee.all

    # Filtering
    employees = employees.where(country: params[:country]) if params[:country].present?
    employees = employees.where(job_title: params[:job_title]) if params[:job_title].present?

    # Pagination
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10

    employees = employees.offset((page - 1) * per_page).limit(per_page)

    render json: employees
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