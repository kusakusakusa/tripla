class User < ApplicationRecord
  has_many :followings
  has_many :followers, through: :followings, class_name: 'User', foreign_key: :follower_id

  has_many :sleep_logs
end
