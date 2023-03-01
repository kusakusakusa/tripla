require 'rails_helper'

RSpec.describe Following, type: :model do
  describe 'associations' do
    let!(:following) { create(:following) }

    scenario 'basic' do
      expect(User.count).to eq 2
      expect(User.first.id).to eq following.user_id
      expect(User.last.id).to eq following.follower_id
      expect(User.first.followers).to eq [User.last]
    end
  end
end
