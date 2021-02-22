class Price < ApplicationRecord
  belongs_to :rank
  belongs_to :menu
end
