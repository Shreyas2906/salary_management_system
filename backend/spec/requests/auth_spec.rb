require 'rails_helper'

RSpec.describe "Auth", type: :request do
  it "logs in and returns token" do
    user = create(:user, password: "123456")

    post "/login", params: { email: user.email, password: "123456" }

    expect(response).to have_http_status(:ok)
  end
end