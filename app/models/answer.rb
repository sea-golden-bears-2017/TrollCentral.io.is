class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question
  has_mnany :votes, as: :voteable
  validates :answer_text, presence: true
end
