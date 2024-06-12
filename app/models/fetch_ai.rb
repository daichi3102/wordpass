# frozen_string_literal: true

class FetchAi < ApplicationRecord
  attr_accessor :prompt_type

  # optional: true を追加してユーザーの関連付けをオプショナルにする
  belongs_to :user, optional: true

  # Ransackで使用するスコープを追加
  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "how", "id", "mood", "popularity", "quote_type", "response", "schedule", "updated_at", "user_id"]
  end
end
