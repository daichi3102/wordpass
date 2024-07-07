# frozen_string_literal: true

FactoryBot.define do
  factory :information do
    visitor_id { 1 }
    visited_id { 1 }
    first_part_id { 1 }
    second_part_id { 1 }
    action { 'MyString' }
    checked { false }
  end
end
