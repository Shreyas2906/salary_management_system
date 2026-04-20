FactoryBot.define do
  factory :attendance do
    association :employee
    days_present { 20 }
    total_working_days { 22 }
  end
end