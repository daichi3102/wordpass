# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      like = build(:like)
      expect(like).to be_valid
    end

    it 'ユーザーがいない場合、バリデーションが機能してinvalidになるか' do
      like = build(:like, user: nil)
      expect(like).to be_invalid
    end

    it 'makeがいない場合、バリデーションが機能してinvalidになるか' do
      like = build(:like, make: nil)
      expect(like).to be_invalid
    end

    it '同じユーザーが同じmakeを複数回likeできない場合、バリデーションが機能してinvalidになるか' do
      user = create(:user)
      make = create(:make, user:, first_part: build(:first_part, user:))
      create(:like, user:, make:)
      duplicate_like = build(:like, user:, make:)
      expect(duplicate_like).to be_invalid
      expect(duplicate_like.errors[:user_id]).to include('はすでに存在します')
    end
  end
end
