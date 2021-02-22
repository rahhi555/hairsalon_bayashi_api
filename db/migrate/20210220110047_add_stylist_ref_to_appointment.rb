class AddStylistRefToAppointment < ActiveRecord::Migration[6.1]
  def change
    add_reference :appointments, :stylist, null: false, foreign_key: true
  end
end
