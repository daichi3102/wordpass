class CreateFirstParts < ActiveRecord::Migration[7.1]
  def change
    create_table :first_parts do |t|
      t.text :content
      t.references :user, null: false, foreign_key: true
      t.references :make, null: false, foreign_key: true

      t.timestamps
    end
  end
end
