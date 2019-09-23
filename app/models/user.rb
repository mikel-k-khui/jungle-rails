class User < ActiveRecord::Base
  has_secure_password
  
  # attr_accessor :email, :password, :password_confirmation
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 4 }
  validates :password, confirmation: { case_sensitive: true }

  def self.authenticate_with_credentials(email, password)
    user = User.where("lower(email) = ?", email.strip.downcase).first

    if user && user.authenticate(password)
      user
    else 
      nil
    end
  end
end
