class User < ApplicationRecord
  has_many :followings
  has_many :friends, through: :followings, class_name: 'User', foreign_key: :friend_id

  has_many :sleep_logs

  def friends_rankings
    ActiveRecord::Base.connection.execute("
      SELECT
        sleep_logs.user_id,
        SUM(
          JULIANDAY(sleep_logs.wake_up_at) - JULIANDAY(sleep_logs.created_at)
        ) AS duration
      FROM sleep_logs
      WHERE sleep_logs.user_id IN (#{friends.ids.join(',')})
        AND sleep_logs.created_at > datetime('now', '-7 day')
      GROUP BY sleep_logs.user_id

      UNION

      SELECT users.id, 0
      FROM users
      LEFT JOIN sleep_logs
        ON users.id = sleep_logs.user_id
      WHERE users.id IN (#{friends.ids.join(',')})
        AND sleep_logs.id IS NULL

      ORDER BY duration DESC
    ").collect do |record|
      record['user_id']
    end
  end
end
