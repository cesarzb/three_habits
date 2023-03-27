FactoryBot.define do
  factory :activity do
    date { Time.now }
    day { nil }
  end
end
