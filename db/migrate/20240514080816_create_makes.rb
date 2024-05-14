class CreateMakes < ActiveRecord::Migration[7.1]
  def change
    create_table :makes do |t|
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
