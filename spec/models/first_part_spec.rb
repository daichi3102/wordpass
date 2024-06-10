# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FirstPart, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      first_part = build(:first_part)
      expect(first_part).to be_valid
    end

    it 'contentが空欄の場合、バリデーションが機能してinvalidになるか' do
      first_part = build(:first_part, content: nil)
      expect(first_part).to be_invalid
    end

    it 'ユーザーがいない場合、バリデーションが機能してinvalidになるか' do
      first_part = build(:first_part, user: nil)
      expect(first_part).to be_invalid
    end

    it 'makeがいない場合、バリデーションが機能してinvalidになるか' do
      first_part = build(:first_part, make: nil)
      expect(first_part).to be_invalid
    end
  end
end
