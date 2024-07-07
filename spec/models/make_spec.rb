# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Make, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      make = build(:make)
      expect(make).to be_valid
    end

    it 'ユーザーがいない場合、バリデーションが機能してinvalidになるか' do
      make = build(:make, user: nil)
      expect(make).to be_invalid
    end

    it 'first_partとsecond_partが両方とも存在しない場合、バリデーションが機能してinvalidになるか' do
      make = build(:make)
      make.first_part = nil
      make.second_part = nil
      expect(make).to be_invalid
      expect(make.errors[:base]).to include('どちらかの句（上の句または下の句）が存在する必要があります')
    end

    it 'first_partが存在する場合、バリデーションが機能してvalidになるか' do
      first_part = build(:first_part)
      make = build(:make, first_part:, second_part: nil)
      expect(make).to be_valid
    end

    it 'second_partが存在する場合、バリデーションが機能してvalidになるか' do
      second_part = build(:second_part)
      make = build(:make, first_part: nil, second_part:)
      expect(make).to be_valid
    end

    it 'first_partとsecond_partの両方が存在する場合、バリデーションが機能してvalidになるか' do
      first_part = build(:first_part)
      second_part = build(:second_part)
      make = build(:make, first_part:, second_part:)
      expect(make).to be_valid
    end
  end
end
