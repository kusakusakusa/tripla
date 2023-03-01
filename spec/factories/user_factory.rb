FactoryBot.define do
  factory :user, aliases: [:follower] do
    full_name { 'John Doe' }
  end
end
