require 'bcrypt'

class User < ActiveRecord::Base
  has_many :answers
  has_many :questions
  has_many :comments
  validates :user_name, presence: true
  validates :email, presence: true
  validates :password_hash, presence: true

  include BCrypt

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    return user if user && user.password == password
    nil
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
