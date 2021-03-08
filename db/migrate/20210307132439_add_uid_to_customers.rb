# frozen_string_literal: true

class AddUidToCustomers < ActiveRecord::Migration[6.1]
  def change
    change_column_null :customers, :uid, false
  end
end
