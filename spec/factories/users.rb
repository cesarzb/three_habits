FactoryBot.define do
  factory :user do
    email { "example@email.com" }
    password { "Password1@" }
    password_confirmation { "Password1@" }
  end
end
