require 'rails_helper'

RSpec.describe "User::SleepLogs", type: :request do
  describe "POST /index" do
    scenario 'should return error if create multiple times within buffer time'

    scenario 'should create sleep log if no sleep logs exist'

    scenario 'should create sleep log if no unstopped sleep logs exist'

    scenario 'should stop sleep log if unstopped sleep logs exist'
  end

  describe "GET /index" do
    scenario 'should return current users sleep logs only, starting from the latest'
  end
end
