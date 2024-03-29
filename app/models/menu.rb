# frozen_string_literal: true

class Menu < ApplicationRecord
  has_and_belongs_to_many :appointments
  has_many :prices, dependent: :destroy
  accepts_nested_attributes_for :prices

  has_many :ranks, through: :prices

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true,
                   format: { with: /\A[A-Z]\z/ }
  validates :time, presence: true
end
