# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Information, type: :model do
  describe 'バリデーションチェック' do
    it 'すべてのバリデーションが機能しているか' do
      information = build(:information)
      expect(information).to be_valid
    end
  end

  describe 'アソシエーションチェック' do
    it 'makeとの関連付けが正しく機能しているか' do
      association = described_class.reflect_on_association(:make)
      expect(association.macro).to eq :belongs_to
    end

    it 'first_partとの関連付けが正しく機能しているか' do
      association = described_class.reflect_on_association(:first_part)
      expect(association.macro).to eq :belongs_to
    end

    it 'second_partとの関連付けが正しく機能しているか' do
      association = described_class.reflect_on_association(:second_part)
      expect(association.macro).to eq :belongs_to
    end

    it 'visitorとの関連付けが正しく機能しているか' do
      association = described_class.reflect_on_association(:visitor)
      expect(association.macro).to eq :belongs_to
      expect(association.class_name).to eq 'User'
    end

    it 'visitedとの関連付けが正しく機能しているか' do
      association = described_class.reflect_on_association(:visited)
      expect(association.macro).to eq :belongs_to
      expect(association.class_name).to eq 'User'
    end
  end
end
