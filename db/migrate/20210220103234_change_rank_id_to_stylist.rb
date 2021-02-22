class ChangeRankIdToStylist < ActiveRecord::Migration[6.1]
  def change
    change_column_null :stylists, :rank_id, null: true
  end
end
