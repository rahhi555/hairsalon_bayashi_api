class Rank < ApplicationRecord
  has_one :stylist
  has_many :prices
  has_many :menu, through: :menus
end
