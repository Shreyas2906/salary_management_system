class CreateAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :attendances do |t|
      t.references :employee, null: false, foreign_key: true
      t.integer :days_present
      t.integer :total_working_days

      t.timestamps
    end
  end
end
