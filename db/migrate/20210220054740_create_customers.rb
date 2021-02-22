class CreateCustomers < ActiveRecord::Migration[6.1]
  def change
    create_table :customers do |t|
      t.string :name,     null: false
      t.string :tel,      null: false
      t.string :mail,     null: false

      t.timestamps
    end
  end
end
