class ChangeNameToRank < ActiveRecord::Migration[6.1]
  def change
    add_index          :ranks, :name, unique: true
  end
end
