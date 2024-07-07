# frozen_string_literal: true

# spec/factories/makes.rb

FactoryBot.define do
  factory :make do
    association :user

    after(:build) do |make|
      make.first_part ||= build(:first_part, make:, user: make.user)
    end
  end
end
