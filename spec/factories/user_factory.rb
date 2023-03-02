FactoryBot.define do
  factory :user, aliases: [:friend] do
    full_name { 'John Doe' }
  end
end
