class AddIndexToCostomers < ActiveRecord::Migration[6.1]
  def change
    add_index :customers, :tel, unique: true
    add_index :customers, :mail, unique: true
  end
end
