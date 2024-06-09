# frozen_string_literal: true

FactoryBot.define do
  factory :first_part do
    content { 'MyText' }
    user { nil }
    make { nil }
  end
end
