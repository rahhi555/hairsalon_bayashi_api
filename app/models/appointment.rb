# frozen_string_literal: true

class Appointment < ApplicationRecord
  belongs_to :customer
  belongs_to :stylist
  has_and_belongs_to_many :menus
end
