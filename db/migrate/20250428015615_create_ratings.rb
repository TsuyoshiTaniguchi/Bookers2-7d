class CreateRatings < ActiveRecord::Migration[6.1]
  def change
    create_table :ratings do |t|
      t.references :book, null: false, foreign_key: true
      t.integer :score

      t.timestamps
    end
  end
end
