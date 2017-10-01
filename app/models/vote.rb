class Vote < ActiveRecord::Base
  belongs_to :voteable, polymorphic: true
  belongs_to :user

  validates :value, numericality: { greater_than: -2, less_than: 2 }
  validates :voteable, presence: true
  validates :user, presence: true
end
