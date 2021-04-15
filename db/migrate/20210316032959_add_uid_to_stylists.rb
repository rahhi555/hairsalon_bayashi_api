class AddUidToStylists < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :uid, :string, null: false
  end
end
