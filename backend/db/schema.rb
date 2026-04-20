# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_04_20_105238) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.integer "days_present"
    t.bigint "employee_id", null: false
    t.integer "total_working_days"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_attendances_on_employee_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "country"
    t.datetime "created_at", null: false
    t.date "date_of_joining"
    t.string "department"
    t.string "full_name"
    t.string "job_title"
    t.decimal "salary"
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email"
    t.bigint "employee_id"
    t.string "password_digest"
    t.integer "role"
    t.datetime "updated_at", null: false
    t.index ["employee_id"], name: "index_users_on_employee_id"
  end

  add_foreign_key "attendances", "employees"
  add_foreign_key "users", "employees"
end
