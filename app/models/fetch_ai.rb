class FetchAi < ApplicationRecord
  attr_accessor :prompt_type

  # optional: true を追加してユーザーの関連付けをオプショナルにする
  belongs_to :user, optional: true
end
