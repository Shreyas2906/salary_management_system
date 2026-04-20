require 'rails_helper'

RSpec.describe "Employees API", type: :request do
  let(:admin) { create(:user, role: :admin, password: "123456") }
  let(:token) { JsonWebToken.encode(user_id: admin.id) }

  let(:headers) do
    { "Authorization" => "Bearer #{token}" }
  end

  let!(:employees) { create_list(:employee, 3) }
  let(:employee_id) { employees.first.id }

  describe "GET /employees" do
    it "returns employees" do
      get "/employees", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).size).to eq(3)
    end
  end

  describe "GET /employees/:id" do
    it "returns the employee" do
      get "/employees/#{employee_id}", headers: headers

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)["id"]).to eq(employee_id)
    end
  end

  describe "POST /employees" do
    let(:valid_params) do
      {
        full_name: "John Doe",
        job_title: "Engineer",
        country: "India",
        salary: 50000,
        department: "Tech"
      }
    end

    it "creates an employee" do
      expect {
        post "/employees", params: valid_params, headers: headers
      }.to change(Employee, :count).by(1)

      expect(response).to have_http_status(:ok)
    end
  end

  describe "PUT /employees/:id" do
    it "updates the employee" do
      put "/employees/#{employee_id}",
          params: { full_name: "Updated Name" },
          headers: headers

      expect(response).to have_http_status(:ok)
      expect(Employee.find(employee_id).full_name).to eq("Updated Name")
    end
  end

  describe "DELETE /employees/:id" do
    it "deletes the employee" do
      expect {
        delete "/employees/#{employee_id}", headers: headers
      }.to change(Employee, :count).by(-1)

      expect(response).to have_http_status(:ok)
    end
  end
end