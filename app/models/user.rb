class User < ApplicationRecord
  has_many :reservations
  has_many :cars, through: :reservations
  belongs_to :role
  validates :email, :first_name, :last_name, :role_id, presence: true
  validates :email, uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, :if => :password # only validate if password changed!


  def admin?
    role.name == 'Admin'
  end

  def super_admin?
    role.name == 'SuperAdmin'
  end

  def customer?
    role.name == 'Customer'
  end
end
