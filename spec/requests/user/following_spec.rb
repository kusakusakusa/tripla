require 'rails_helper'

RSpec.describe "User::Followings", type: :request do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }
  let!(:second_friend) { create(:user) }
  let(:third_friend) { create(:user) }

  describe 'POST /user/followings?friend_id' do
    scenario 'should follow friend' do
      post '/user/followings', params: { followings: { friend_id: friend.id } }
      expect(Following.count).to eq 1
      expect(response_body.following.id).to eq Following.first.id
      expect(user.followings.size).to eq 1
      expect(user.friends.size).to eq 1

      post '/user/followings', params: { followings: { friend_id: second_friend.id } }
      expect(Following.count).to eq 2
      expect(response_body.following.id).to eq Following.last.id
      expect(user.followings.reload.size).to eq 2
      expect(user.friends.reload.size).to eq 2
    end

    scenario 'should return error if friend_id not provided' do
      post '/user/followings'
      expect(response_body.error).to eq 'param is missing or the value is empty: followings'
      post '/user/followings', params: { followings: { something: second_friend.id } }
      expect(response_body.error).to eq "Validation failed: Friend must exist, Friend can't be blank"
    end

    scenario 'should not follow self' do
      post '/user/followings', params: { followings: { friend_id: user.id } }
      expect(response_body.error).to eq "Validation failed: Friend must be other than #{user.id}"
      expect(Following.count).to eq 0
    end

    scenario 'should not follow same person twice, but show success if so' do
      post '/user/followings', params: { followings: { friend_id: friend.id } }
      expect(Following.count).to eq 1
      expect(response_body.following.id).to eq Following.first.id
      expect(user.followings.size).to eq 1
      expect(user.friends.size).to eq 1

      post '/user/followings', params: { followings: { friend_id: friend.id } }
      expect(Following.count).to eq 1
      expect(response_body.following.id).to eq Following.first.id
      expect(user.followings.size).to eq 1
      expect(user.friends.size).to eq 1
    end
  end

  describe 'DELETE /user/followings/:id' do
    let!(:following_friend) { create(:following, friend:, user:) }
    let!(:following_second_friend) { create(:following, friend: second_friend, user:) }
    let!(:following_stranger) { create(:following) }

    before :each do
      expect(user.followings.count).to eq 2
    end

    scenario 'should unfollow correct friend' do
      delete "/user/followings/#{following_friend.id}"
      expect(response_body.following.id).to eq following_friend.id
      expect(user.followings.count).to eq 1
      expect(user.followings.first.friend).to eq second_friend
    end

    scenario 'should still show success if following does not exist or invalid' do
      delete "/user/followings/0"
      expect(response_body.following).to eq nil

      delete "/user/followings/#{following_stranger.id}"
      expect(response_body.following).to eq nil
      expect(user.followings.count).to eq 2
    end
  end

  describe 'GET /user/followings/sleep_logs' do
    let!(:less_sleep_friend) { friend }
    let!(:more_sleep_friend) { second_friend }
    let!(:less_active_friend) { third_friend }
    let!(:inactive_friend) { create(:user) }
    let!(:following_less_sleep_friend) { create(:following, friend: less_sleep_friend, user:) }
    let!(:following_more_sleep_friend) { create(:following, friend: more_sleep_friend, user:) }
    let!(:following_less_active_friend) { create(:following, friend: less_active_friend, user:) }
    let!(:following_inactive_friend) { create(:following, friend: inactive_friend, user:) }

    let!(:following_stranger) { create(:following) } # control

    before :each do
      (21.days.ago.to_date..Date.today).to_a.each do |date|
        create(
          :sleep_log,
          user:,
          created_at: date.to_time - rand(0..4).hours,
          wake_up_at: date.to_time + rand(8..12).hours
        )
        little_sleep_hours = rand(4..6).hours
        create(
          :sleep_log,
          user: less_sleep_friend,
          created_at: date.to_time - rand(0..2).hours,
          wake_up_at: date.to_time + little_sleep_hours
        )
        much_sleep_hours = rand(8..12).hours
        create(
          :sleep_log,
          user: more_sleep_friend,
          created_at: date.to_time - rand(0..2).hours,
          wake_up_at: date.to_time + much_sleep_hours
        )
        unless date.on_weekend?
          create(
            :sleep_log,
            user: less_active_friend,
            created_at: date.to_time,
            wake_up_at: date.to_time + 4.hours # ensure less than less_sleep_friend
          )
        end
        create(
          :sleep_log,
          user: following_stranger.user,
          created_at: date.to_time - rand(0..4).hours,
          wake_up_at: date.to_time + rand(8..12).hours
        )
      end
    end

    scenario 'should return sleep_logs of all friends only, ranked by length of sleep in descending order' do
      get '/user/followings/sleep_logs'
      expect(response_body.friends.size).to eq 4

      [
        more_sleep_friend,
        less_sleep_friend,
        less_active_friend,
        inactive_friend
      ].each_with_index do |friend, index|
        friend_json = response_body.friends[index]
        expect(friend_json.id).to eq friend.id

        sleep_logs = friend_json.sleep_logs
        if friend == inactive_friend
          expect(sleep_logs.size).to eq 0
        else
          expect(sleep_logs.map(&:created_at)).to eq sleep_logs.sort_by(&:created_at).reverse.map(&:created_at)
        end
      end
    end
  end
end
