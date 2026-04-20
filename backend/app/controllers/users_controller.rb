class UsersController < ApplicationController
  def dashboard
    employee = Employee.find_by(id: @current_user.employee_id)

    attendance = Attendance.find_by(employee_id: employee.id)

    today = Date.today
    total_days_in_month = today.end_of_month.day

    days_present = attendance&.days_present || 0

    salary = employee.salary.to_f

    per_day_salary = salary / total_days_in_month
    earned_salary = per_day_salary * days_present

    tax = earned_salary * 0.1
    net = earned_salary - tax

    render json: {
      salary: salary,
      attendance: {
        days_present: days_present,
        total_days_in_month: total_days_in_month
      },
      payroll: {
        per_day: per_day_salary.round(2),
        earned: earned_salary.round(2),
        tax: tax.round(2),
        net: net.round(2)
      }
    }
  end
end