class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.references :customer, null: false, foreign_key: true
      t.datetime :appointment_on
      t.text :remark

      t.timestamps
    end
  end
end
