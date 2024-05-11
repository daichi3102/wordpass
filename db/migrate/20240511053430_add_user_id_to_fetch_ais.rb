class AddUserIdToFetchAis < ActiveRecord::Migration[7.1]
  def change
    add_reference :fetch_ais, :user, null: true, foreign_key: true
  end
end
