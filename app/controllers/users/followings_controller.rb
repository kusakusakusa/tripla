module Users
  class FollowingsController < UserController
    def create
      following = current_user.followings.find_or_create_by!(friend_id: following_params[:friend_id])
      render json: { following: }
    end

    def destroy
      following = current_user.followings.find(params[:id])
      following.destroy!
      render json: { following: }
    rescue ActiveRecord::RecordNotFound
      render json: { following: }
    end

    def sleep_logs
      @friends_hash = current_user.friends.group_by(&:id)
      @logs = SleepLog.where(user: current_user.friends, created_at: 1.week.ago..).order(created_at: :desc).group_by do |sleep_log|
        sleep_log.user_id
      end
    end

    private

    def following_params
      params.require(:followings).permit(:friend_id)
    end
  end
end
