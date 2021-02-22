class CreateStylists < ActiveRecord::Migration[6.1]
  def change
    create_table :stylists do |t|
      t.references :rank, null: false, foreign_key: true
      t.string :name, null: false
      t.boolean :is_male, null: false
      t.string :nickname
      t.date :hire_on, null: false

      t.timestamps
    end
  end
end
