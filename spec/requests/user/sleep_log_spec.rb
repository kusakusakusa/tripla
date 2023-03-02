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
    scenario 'should return current users sleep logs only, starting from the latest'
  end
end
