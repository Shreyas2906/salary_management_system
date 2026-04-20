require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  describe "GET /employees" do
    it "returns employees" do
      create_list(:employee, 3)
      get "/employees"

      expect(response).to have_http_status(:ok)
    end
  end
end