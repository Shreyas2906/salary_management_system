require 'rails_helper'

RSpec.describe User, type: :model do
  it "is valid with valid attributes" do
    expect(build(:user)).to be_valid
  end

  it "is invalid without email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is invalid with duplicate email" do
    create(:user, email: "test@example.com")
    user = build(:user, email: "test@example.com")

    expect(user).not_to be_valid
  end

  it "defaults to employee role" do
    user = User.new(email: "test@test.com", password: "123456")
    user.valid?

    expect(user.role).to eq("employee")
  end

  it "can be admin role" do
    user = create(:user, role: :admin)
    expect(user.admin?).to be true
  end
end