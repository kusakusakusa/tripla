class Following < ApplicationRecord
  belongs_to :user
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'

  validates :follower_id, comparison: { other_than: :user_id }
end
