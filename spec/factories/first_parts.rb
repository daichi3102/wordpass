# frozen_string_literal: true

FactoryBot.define do
  factory :first_part do
    content { '本番環境で見てみようか' }
    association :user
    association :make
  end
end
