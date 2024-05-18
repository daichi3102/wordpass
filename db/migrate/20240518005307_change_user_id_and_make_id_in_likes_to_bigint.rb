class ChangeUserIdAndMakeIdInLikesToBigint < ActiveRecord::Migration[6.0]
  def change
    change_column :likes, :user_id, :bigint
    change_column :likes, :make_id, :bigint
  end
end
