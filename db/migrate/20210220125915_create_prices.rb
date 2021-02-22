class CreatePrices < ActiveRecord::Migration[6.1]
  def change
    create_table :prices do |t|
      t.references :rank, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.integer :price, null: false

      t.timestamps
    end
  end
end
