# models/user.rb
class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save { self.email = email.strip.downcase }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email,
            presence: true,
            format: {
              with: VALID_EMAIL_REGEX,
            },
            uniqueness: true
  validates :password, presence: true, length: { minimum: 4 }
  validates_presence_of :password_confirmation
  validates_confirmation_of :password, message: 'should match confirmation'

  has_secure_password
  has_many :reviews

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by(email: email.strip.downcase)
    @user && @user.authenticate(password) ? @user : nil
  end
end
