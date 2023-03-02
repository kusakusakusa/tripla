module Users
  class SleepLogsController < UserController
    BUFFER_DURATION = 5.minutes

    def create
      sleep_log = current_user.sleep_logs.latest_active

      if sleep_log.nil?
        sleep_log = current_user.sleep_logs.create
      elsif sleep_log.created_at < BUFFER_DURATION.ago
        sleep_log.update(wake_up_at: Time.current)
      end

      render json: { sleep_log: }
    end

    def index
      render json: { sleep_logs: current_user.sleep_logs.order(created_at: :desc) }
    end
  end
end
