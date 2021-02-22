class CreateAppointmentsMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments_menus, id: false do |t|
      t.belongs_to :appointment
      t.belongs_to :menu
    end
  end
end
