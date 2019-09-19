class User < ActiveRecord::Base
  has_secure_password
  
  # attr_accessor :email, :password, :password_confirmation
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates_uniqueness_of :email
end
