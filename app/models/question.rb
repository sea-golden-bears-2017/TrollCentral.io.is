class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  has_many :votes, as: :voteable
  has_many :comments, as: :commentable

  validates :question_text, presence: true
  validates :user_id, presence: true
end
