# frozen_string_literal: true

class FetchAi < ApplicationRecord
  attr_accessor :prompt_type

  # optional: true を追加してユーザーの関連付けをオプショナルにする
  belongs_to :user, optional: true

  default_scope { order(created_at: :desc) }

  # Ransackで使用するスコープを追加
  def self.ransackable_attributes(_auth_object = nil)
    %w[created_at how id mood popularity quote_type response schedule updated_at user_id]
  end
end
