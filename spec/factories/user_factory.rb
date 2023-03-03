FactoryBot.define do
  factory :user, aliases: [:friend] do
    full_name { 'stub' }

    after :create do |record|
      record.update(full_name: "user #{record.id}")
    end
  end
end
