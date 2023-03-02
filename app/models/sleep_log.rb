class SleepLog < ApplicationRecord
  belongs_to :user

  def self.latest_active
    where(wake_up_at: nil).order(created_at: :desc).first
  end

  def log_time
    update(wake_up_at: Time.current)
  end
end
