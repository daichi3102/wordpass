class FetchAi < ApplicationRecord
  # optional: true を追加してユーザーの関連付けをオプショナルにする
  belongs_to :user, optional: true
end
