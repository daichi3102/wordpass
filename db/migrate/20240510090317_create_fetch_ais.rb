class CreateFetchAis < ActiveRecord::Migration[7.1]
  def change
    create_table :fetch_ais do |t|
      t.string :mood
      t.string :schedule
      t.string :how
      t.string :popularity
      t.string :quote_type
      t.text :response

      t.timestamps
    end
  end
end
