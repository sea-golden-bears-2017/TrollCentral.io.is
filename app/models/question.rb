class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  has_many :votes, as: :voteable
  validates :question_text, presence: true
end
