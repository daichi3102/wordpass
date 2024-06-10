# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FetchAi, type: :model do
  describe 'バリデーションチェック' do
    it '設定したすべてのバリデーションが機能しているか' do
      fetch_ai = build(:fetch_ai)
      expect(fetch_ai).to be_valid
    end

    it 'userが存在しなくても保存できるか' do
      fetch_ai = build(:fetch_ai, user: nil)
      expect(fetch_ai).to be_valid
    end
  end
end
