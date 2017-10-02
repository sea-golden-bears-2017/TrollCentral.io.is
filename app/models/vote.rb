class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value, numericality: { greater_than: -2, less_than: 2 }
  validates :voteable, presence: true
  validates :user, presence: true

  validate :user_can_only_vote_once

  def user_can_only_vote_once
    vote = Vote.find_by(voteable: self.voteable)
    if vote && vote.user == self.user
      errors.add(:user, "can only vote for the same thing once.")
    end
  end
end
