require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'nameが空欄の場合、バリデーションが機能してinvalidになるか' do
      user = build(:user, name: nil)
      expect(user).to be_invalid
    end

    it 'emailが空欄の場合、バリデーションが機能してinvaildになるか' do
      user = build(:user, email: nil)
      expect(user).to be_invalid
    end

    it 'emailが重複している場合、バリデーションが機能してinvaildになるか' do
      create(:user, email: 'meigenotter@example.com')
      user = build(:user, email: 'meigenotter@example.com')
      expect(user).to be_invalid
    end

    it 'passwordが空欄の場合、バリデーションが機能してinvaildになるか' do
      user = build(:user, password: nil)
      expect(user).to be_invalid
    end

    it 'passwordが6文字未満の場合、バリデーションが機能してinvaildになるか' do
      user = build(:user, password: 'pass', password_confirmation: 'pass')
      expect(user).to be_invalid
    end
  end
end
