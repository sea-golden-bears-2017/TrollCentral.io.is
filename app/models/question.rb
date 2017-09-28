class Question < ActiveRecord::Base
  has_many :answers
  belongs_to :user
  validates :question_text, presence: true
end
