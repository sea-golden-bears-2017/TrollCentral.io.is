class Comment < ActiveRecord::Base
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true
  validates :comment_text, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :user
end
