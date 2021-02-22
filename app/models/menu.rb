class Menu < ApplicationRecord
  has_and_belongs_to_many :appointments
  has_many :prices
  has_many :ranks, through: :prices
end
