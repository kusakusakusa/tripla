module Users
  class FollowingsController < UserController
    def create
      following = current_user.followings.find_or_create_by!(friend_id: following_params[:friend_id])
      render json: { following: }
    end

    private

    def following_params
      params.require(:followings).permit(:friend_id)
    end
  end
end
