# frozen_string_literal: true

FactoryBot.define do
  factory :second_part do
    content { 'MyText' }
    user { nil }
    make { nil }
  end
end
