# frozen_string_literal: true

class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :make_id

      t.timestamps
    end
  end
end
