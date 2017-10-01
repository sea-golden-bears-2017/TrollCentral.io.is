class User < ActiveRecord::Base
  has_many :answers
  has_many :questions
  has_many :comments
  validates :user_name, presence: true
  validates :email, presence: true
  validates :password_hash, presence: true
end
