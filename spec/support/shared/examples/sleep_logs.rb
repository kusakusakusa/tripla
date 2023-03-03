RSpec.shared_examples 'common POST /user/sleep_logs' do
  scenario 'should create sleep log if no sleep logs exist' do
    post '/user/sleep_logs'
    expect(response_body.sleep_log.id).to eq SleepLog.first.id
    expect(response_body.sleep_log.user_id).to eq user.id
  end

  scenario 'should create sleep log if no active sleep logs exist' do
    sleep_log = create(:sleep_log, :woke_up, user:)
    post '/user/sleep_logs'
    expect(response_body.sleep_log.id).not_to eq sleep_log.id
    expect(response_body.sleep_log.user_id).to eq user.id
    expect(response_body.sleep_log.wake_up_at).to eq nil
    expect(user.sleep_logs.size).to eq 2
  end

  describe 'with active sleep log' do
    let!(:sleep_log) { create(:sleep_log, user:) }

    scenario 'should return latest sleep_log if create multiple times within buffer time' do
      post '/user/sleep_logs'
      expect(response_body.sleep_log.id).to eq sleep_log.id
      expect(response_body.sleep_log.wake_up_at).to eq nil
      expect(user.sleep_logs.reload.size).to eq 1
    end

    scenario 'should stop sleep log if an active sleep log exist' do
      post '/user/sleep_logs'
      Timecop.travel(Users::SleepLogsController::BUFFER_DURATION + 1.second) do
        post '/user/sleep_logs'
        expect(response_body.sleep_log.id).to eq sleep_log.id
        expect(response_body.sleep_log.wake_up_at).not_to eq nil
        expect(user.sleep_logs.reload.size).to eq 1
      end
    end
  end
end
