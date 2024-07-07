# frozen_string_literal: true

class CreateInformation < ActiveRecord::Migration[7.1]
  def change
    create_table :information do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.integer :make_id
      t.integer :first_part_id
      t.integer :second_part_id
      t.string :action, default: '', null: false
      t.boolean :checked, default: false, null: false

      t.timestamps
    end
  end
end
