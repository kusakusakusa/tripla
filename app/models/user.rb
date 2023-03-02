class User < ApplicationRecord
  has_many :followings
  has_many :friends, through: :followings, class_name: 'User', foreign_key: :friend_id

  has_many :sleep_logs
end
