# frozen_string_literal: true

class UpdateLikesTable < ActiveRecord::Migration[7.1]
  def change
    add_index :likes, :make_id, name: 'index_likes_on_make_id'
    add_index :likes, %i[user_id make_id], name: 'index_likes_on_user_id_and_make_id', unique: true
    add_index :likes, :user_id, name: 'index_likes_on_user_id'
  end
end
