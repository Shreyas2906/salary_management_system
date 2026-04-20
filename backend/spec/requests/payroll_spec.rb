require 'rails_helper'

RSpec.describe "Payroll API", type: :request do
  let(:admin) { create(:user, role: :admin, password: "123456") }
  let(:token) { JsonWebToken.encode(user_id: admin.id) }

  let(:headers) do
    { "Authorization" => "Bearer #{token}" }
  end

  let(:employee) { create(:employee, salary: 1000, country: "India") }

  let!(:attendance) do
    create(:attendance,
      employee: employee,
      days_present: 20,
      total_working_days: 20
    )
  end

  describe "GET /payroll/:employee_id" do
    it "returns calculated payroll" do
      get "/payroll/#{employee.id}", headers: headers

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json["gross"]).to eq(1000.0)
      expect(json["tax"]).to eq(100.0)
      expect(json["net"]).to eq(900.0)
    end
  end
end