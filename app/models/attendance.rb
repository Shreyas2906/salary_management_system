class Attendance < ApplicationRecord
  belongs_to :employee

  validates :employee_id, :days_present, :total_working_days, presence: true
  validate :days_present_cannot_exceed_total

  private

  def days_present_cannot_exceed_total
    return if days_present.nil? || total_working_days.nil?

    if days_present > total_working_days
      errors.add(:days_present, "cannot exceed total working days")
    end
  end
end