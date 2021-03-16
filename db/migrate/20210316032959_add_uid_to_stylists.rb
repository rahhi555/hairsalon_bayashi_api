class AddUidToStylists < ActiveRecord::Migration[6.1]
  def change
    add_column :stylists, :uid, :string, null: false
  end
end
