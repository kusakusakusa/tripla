require 'rails_helper'

RSpec.describe "User::SleepLogs", type: :request do
  let!(:user) { create(:user) }

  describe "POST /user/sleep_logs" do
    include_examples 'common POST /user/sleep_logs'

    describe 'multiple users' do
      let!(:second_user) { create(:user) }

      include_examples 'common POST /user/sleep_logs'
    end
  end

  describe "GET /index" do
    let!(:yesterday_sleep_log) { create(:sleep_log, :yesterday, user:) }
    let!(:sleep_log) { create(:sleep_log, user:) }
    let!(:second_user) { create(:user) }
    let!(:second_user_sleep_log) { create(:sleep_log, user: second_user) }

    scenario 'should return current users sleep logs only, starting from the latest' do
      get '/user/sleep_logs'
      expect(response_body['sleep_logs'].size).to eq 2
      expect(response_body['sleep_logs'].first.id).to eq sleep_log.id
      expect(response_body['sleep_logs'].last.id).to eq yesterday_sleep_log.id
    end
  end
end
