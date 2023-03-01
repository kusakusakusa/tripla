require 'rails_helper'

RSpec.describe "User::Followings", type: :request do
  describe 'POST /user/followings?follower_id' do
    scenario 'should follow user'

    scenario 'should return error if follower_id not provided'

    scenario 'should not follow self, but show success if so'

    scenario 'should not follow same person twice, but show success if so'
  end

  describe 'DELETE /user/followings/:id' do
    scenario 'should unfollow user'
  end

  describe 'GET /user/followings/sleep_logs' do
    scenario 'should return sleep_logs of all followers only, ranked by length of sleep in descending order'
  end
end
