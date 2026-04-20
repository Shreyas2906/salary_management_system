# db/seeds.rb

require 'faker'

puts "🚀 Starting seeding..."

# -----------------------------
# CONFIG
# -----------------------------
EMPLOYEE_COUNT = 100
ATTENDANCE_SAMPLE = 92
USER_SAMPLE = 100

FIRST_NAMES = %w[Amit Rahul Neha Priya John Jane Alex Chris]
LAST_NAMES  = %w[Sharma Verma Singh Patel Smith Doe Brown Taylor]

JOB_TITLES = ["Engineer", "Manager", "HR", "Analyst"]
COUNTRIES  = ["India", "USA", "UK"]
DEPARTMENTS = ["Tech", "HR", "Finance"]

NOW = Time.now

# -----------------------------
# CLEANUP (optional but useful)
# -----------------------------
puts "🧹 Cleaning old data..."
Attendance.delete_all if defined?(Attendance)
User.delete_all if defined?(User)
Employee.delete_all

# -----------------------------
# EMPLOYEES (FAST BULK INSERT)
# -----------------------------
puts "👥 Creating employees..."

employee_records = Array.new(EMPLOYEE_COUNT) do
  {
    full_name: "#{FIRST_NAMES.sample} #{LAST_NAMES.sample}",
    job_title: JOB_TITLES.sample,
    country: COUNTRIES.sample,
    salary: rand(30_000..150_000),
    department: DEPARTMENTS.sample,
    created_at: NOW,
    updated_at: NOW
  }
end

Employee.insert_all(employee_records)

employee_ids = Employee.pluck(:id)

puts "✅ Employees created: #{employee_ids.size}"

# -----------------------------
# USERS (Admin + Employees)
# -----------------------------
puts "🔐 Creating users..."

# Admin user
User.create!(
  email: "admin@example.com",
  password: "password",
  role: :admin
)

# # Employee users
# user_records = employee_ids.sample(USER_SAMPLE).map do |emp_id|
#   {
#     email: Faker::Internet.unique.email,
#     password_digest: BCrypt::Password.create("password"),
#     role: User.roles[:employee],
#     employee_id: emp_id,
#     created_at: NOW,
#     updated_at: NOW
#   }
# end

user_records = employee_ids.sample(USER_SAMPLE).map.with_index do |emp_id, index|
  {
    email: "employee#{index + 1}@example.com",  # ✅ predictable
    password_digest: BCrypt::Password.create("password"),
    role: User.roles[:employee],
    employee_id: emp_id,
    created_at: NOW,
    updated_at: NOW
  }
end

User.insert_all(user_records)

puts "✅ Users created: #{User.count}"

# -----------------------------
# ATTENDANCE
# -----------------------------
puts "📅 Creating attendance..."

attendance_records = employee_ids.sample(ATTENDANCE_SAMPLE).map do |emp_id|
  {
    employee_id: emp_id,
    days_present: rand(15..22),
    total_working_days: 22,
    created_at: NOW,
    updated_at: NOW
  }
end

Attendance.insert_all(attendance_records)

puts "✅ Attendance records: #{Attendance.count}"

# -----------------------------
# DONE
# -----------------------------
puts "🎉 Seeding completed successfully!"