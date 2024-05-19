class AddIndexesAndForeignKeysToLikes < ActiveRecord::Migration[7.1]
  def change
    # 外部キー制約を追加
    add_foreign_key :likes, :users
    add_foreign_key :likes, :makes
  end
end
