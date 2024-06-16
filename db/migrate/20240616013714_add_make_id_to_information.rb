class AddMakeIdToInformation < ActiveRecord::Migration[7.1]
  def change
    add_column :information, :make_id, :integer
  end
end
