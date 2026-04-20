class Employee < ApplicationRecord
	has_many :attendances, dependent: :destroy
	validates :full_name, :job_title, :country, :salary, presence: true
end
