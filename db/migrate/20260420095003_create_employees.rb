class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :full_name
      t.string :job_title
      t.string :country
      t.decimal :salary
      t.string :department
      t.date :date_of_joining

      t.timestamps
    end
  end
end
