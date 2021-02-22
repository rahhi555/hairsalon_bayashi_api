class Appointment < ApplicationRecord
  belongs_to :customer
  has_and_belongs_to_many :menus
end
