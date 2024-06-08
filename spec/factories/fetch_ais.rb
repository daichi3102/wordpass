# frozen_string_literal: true

FactoryBot.define do
  factory :fetch_ai do
    mood { 'MyString' }
    schedule { 'MyString' }
    how { 'MyString' }
    popularity { 'MyString' }
    quote_type { 'MyString' }
    response { 'MyText' }
  end
end
