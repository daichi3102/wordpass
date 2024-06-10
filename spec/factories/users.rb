FactoryBot.define do
  factory :user do
    name { 'ラッコ' }
    sequence(:email) { |n| "meigenotter#{n}@example.com" }
    password { 'password' }
    password_confirmation { 'password' }
  end
end
