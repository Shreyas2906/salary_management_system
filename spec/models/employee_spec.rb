require 'rails_helper'

RSpec.describe Employee, type: :model do
  it "is valid with valid attributes" do
    employee = build(:employee)
    expect(employee).to be_valid
  end

  it "is invalid without full_name" do
    employee = build(:employee, full_name: nil)
    expect(employee).not_to be_valid
  end

  it "is invalid without salary" do
    employee = build(:employee, salary: nil)
    expect(employee).not_to be_valid
  end
end