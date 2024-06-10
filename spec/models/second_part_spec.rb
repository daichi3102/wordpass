# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SecondPart, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      second_part = build(:second_part)
      expect(second_part).to be_valid
    end

    it 'contentが空欄の場合、バリデーションが機能してinvalidになるか' do
      second_part = build(:second_part, content: nil)
      expect(second_part).to be_invalid
    end

    it 'ユーザーがいない場合、バリデーションが機能してinvalidになるか' do
      second_part = build(:second_part, user: nil)
      expect(second_part).to be_invalid
    end

    it 'makeがいない場合、バリデーションが機能してinvalidになるか' do
      second_part = build(:second_part, make: nil)
      expect(second_part).to be_invalid
    end
  end
end
