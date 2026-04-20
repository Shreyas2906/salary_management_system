class Employee < ApplicationRecord
	has_many :attendances, dependent: :destroy
   
	has_one :user
	validates :full_name, :job_title, :country, :salary, presence: true
end
