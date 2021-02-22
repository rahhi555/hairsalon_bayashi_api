class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :code, null: false, index: { unique: true }
      t.time :time,   null: false

      t.timestamps
    end
  end
end
