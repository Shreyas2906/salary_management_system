class PayrollController < ApplicationController
  before_action :require_admin

  def show
    employee = Employee.find(params[:employee_id])
    attendance = employee.attendances.last

    return render json: { error: "Attendance not found" }, status: :not_found unless attendance

    result = PayrollCalculator.calculate(employee, attendance)

    render json: result.transform_values(&:to_f)
  end

  private

  def require_admin
    render json: { error: "Forbidden" }, status: :forbidden unless @current_user.admin?
  end
end