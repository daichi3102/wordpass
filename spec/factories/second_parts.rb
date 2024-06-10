# frozen_string_literal: true

FactoryBot.define do
  factory :second_part do
    content { 'あー...シンタックス入っちゃったね' }
    association :user
    association :make
  end
end
