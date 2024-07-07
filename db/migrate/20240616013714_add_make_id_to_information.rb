# frozen_string_literal: true

class AddMakeIdToInformation < ActiveRecord::Migration[7.1]
  def change
    return if column_exists? :information, :make_id

    add_column :information, :make_id, :integer
  end
end
