# frozen_string_literal: true

class AddUidToCustomers < ActiveRecord::Migration[6.1]
  def change
    add_column :stylists, :uid, :string, null: false
  end
end
