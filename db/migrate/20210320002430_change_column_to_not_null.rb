class ChangeColumnToNotNull < ActiveRecord::Migration[6.1]
  # ランクかメニューを作成する際にpriceが空のpricesカラムを作成する必要があるので変更
  def up
    change_column :prices, :price, :integer, null: true
  end
  
  def down
    change_column :prices, :price, :integer, null: false
  end
end
