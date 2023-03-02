class Following < ApplicationRecord
  belongs_to :user
  belongs_to :friend, foreign_key: :friend_id, class_name: 'User'

  validates :friend_id, comparison: { other_than: :user_id }
end
