FactoryBot.define do
  factory :employee do
    full_name { Faker::Name.name }
    job_title { "Engineer" }
    country { "India" }
    salary { 50000 }
    department { "Tech" }
    date_of_joining { Date.today }
  end
end