class AddAuthToStylists < ActiveRecord::Migration[6.1]
  def change
    add_column :stylists, :tel, :string, null: false
    add_check_constraint :stylists, "tel REGEXP '^0[[:digit:]]{9,10}$'", name: "stylists_only_phone_number"
    add_column :stylists, :mail, :string, null: false
    add_check_constraint :stylists, "mail REGEXP '^[A-Z0-9._%-]+@[A-Z0-9.-]+.[A-Z]{2,4}$'", name: "stylists_only_mail_address"
  end
end
