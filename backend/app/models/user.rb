class User < ApplicationRecord
  has_secure_password
  belongs_to :employee, optional: true
  
  enum :role, { employee: 0, admin: 1 }

  validates :email, presence: true, uniqueness: true

  after_initialize :set_default_role, if: :new_record?

  private

  def set_default_role
    self.role ||= "employee"
  end
end