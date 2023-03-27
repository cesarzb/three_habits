FactoryBot.define do
  factory :day do
    date { Time.now.beginning_of_day }
  end
end
