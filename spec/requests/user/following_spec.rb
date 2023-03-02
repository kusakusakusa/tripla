require 'rails_helper'

RSpec.describe "User::Followings", type: :request do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:second_friend) { create(:user) }
  let!(:stranger) { create(:user) }

  describe 'POST /user/followings?friend_id' do
    scenario 'should follow friend' do
      post '/user/followings', params: { followings: { friend_id: friend.id } }
      expect(Following.count).to eq 1
      expect(response_body[:following].id).to eq Following.first.id
      expect(user.followings.size).to eq 1
      expect(user.friends.size).to eq 1

      post '/user/followings', params: { followings: { friend_id: second_friend.id } }
      expect(Following.count).to eq 2
      expect(response_body[:following].id).to eq Following.last.id
      expect(user.followings.reload.size).to eq 2
      expect(user.friends.reload.size).to eq 2
    end

    scenario 'should return error if friend_id not provided' do
      post '/user/followings'
      expect(response_body[:error]).to eq 'param is missing or the value is empty: followings'
      post '/user/followings', params: { followings: { something: second_friend.id } }
      expect(response_body[:error]).to eq "Validation failed: Friend must exist, Friend can't be blank"
    end

    scenario 'should not follow self' do
      post '/user/followings', params: { followings: { friend_id: user.id } }
      expect(response_body[:error]).to eq "Validation failed: Friend must be other than #{user.id}"
      expect(Following.count).to eq 0
    end

    scenario 'should not follow same person twice, but show success if so' do
      post '/user/followings', params: { followings: { friend_id: friend.id } }
      expect(user.followings.size).to eq 1
      expect(user.friends.size).to eq 1
      post '/user/followings', params: { followings: { friend_id: friend.id } }
      expect(user.followings.size).to eq 1
      expect(user.friends.size).to eq 1
    end
  end

  describe 'DELETE /user/followings/:id' do
    scenario 'should unfollow user'
  end

  describe 'GET /user/followings/sleep_logs' do
    scenario 'should return sleep_logs of all followers only, ranked by length of sleep in descending order'
  end
end
