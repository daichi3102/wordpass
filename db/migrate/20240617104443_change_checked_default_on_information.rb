# frozen_string_literal: true

class ChangeCheckedDefaultOnInformation < ActiveRecord::Migration[7.1]
  def change
    change_column :information, :checked, :boolean, default: false, null: false
  end
end
