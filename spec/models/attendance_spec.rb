require 'rails_helper'

RSpec.describe Attendance, type: :model do
  it "is valid with valid attributes" do
    employee = create(:employee)
    attendance = Attendance.new(
      employee: employee,
      days_present: 20,
      total_working_days: 22
    )

    expect(attendance).to be_valid
  end

  it "is invalid without employee" do
    attendance = Attendance.new(days_present: 20, total_working_days: 22)
    expect(attendance).not_to be_valid
  end

  it "is invalid if days_present > total_working_days" do
    employee = create(:employee)
    attendance = Attendance.new(
      employee: employee,
      days_present: 25,
      total_working_days: 22
    )

    expect(attendance).not_to be_valid
  end
end