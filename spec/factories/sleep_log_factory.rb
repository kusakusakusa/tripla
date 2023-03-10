FactoryBot.define do
  factory :sleep_log do
    user
    created_at { Time.current }

    trait :woke_up do
      created_at { 8.hours.ago }
      wake_up_at { Time.current }
    end

    trait :yesterday do
      created_at { 24.hours.ago }
      wake_up_at { 16.hours.ago }
    end
  end
end
