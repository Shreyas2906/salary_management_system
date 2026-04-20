class AttendancesController < ApplicationController
  before_action :require_admin

  def index
    page = params[:page].to_i > 0 ? params[:page].to_i : 1
    per_page = params[:per_page].to_i > 0 ? params[:per_page].to_i : 10

    attendances = Attendance
                    .includes(:employee)
                    .order(created_at: :desc)
                    .offset((page - 1) * per_page)
                    .limit(per_page)

    render json: attendances.as_json(
      include: {
        employee: {
          only: [:id, :full_name, :job_title]
        }
      }
    )
  end

  def create
    attendance = Attendance.create!(attendance_params)

    render json: attendance
  end

  private

  def attendance_params
    params.require(:attendance).permit(:employee_id, :days_present, :total_working_days)
  end

  def require_admin
    render json: { error: "Forbidden" }, status: :forbidden unless @current_user.admin?
  end
end