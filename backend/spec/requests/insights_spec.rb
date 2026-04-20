require 'rails_helper'

RSpec.describe "Insights API", type: :request do
  let(:admin) { create(:user, role: :admin, password: "123456") }
  let(:token) { JsonWebToken.encode(user_id: admin.id) }

  let(:headers) do
    { "Authorization" => "Bearer #{token}" }
  end

  before do
    create(:employee, country: "India", salary: 1000, job_title: "Engineer")
    create(:employee, country: "India", salary: 2000, job_title: "Engineer")
    create(:employee, country: "India", salary: 3000, job_title: "Manager")
  end

  describe "GET /insights/salary" do
    it "returns min, max, avg salary for a country" do
      get "/insights/salary", params: { country: "India" }, headers: headers

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["min"]).to eq(1000.0)
      expect(json["max"]).to eq(3000.0)
      expect(json["avg"]).to eq(2000.0)
    end
  end

  describe "GET /insights/job_title" do
    it "returns avg salary for job title in a country" do
      get "/insights/job_title",
          params: { country: "India", job_title: "Engineer" },
          headers: headers

      json = JSON.parse(response.body)

      expect(response).to have_http_status(:ok)
      expect(json["avg"]).to eq(1500.0)
    end
  end
end