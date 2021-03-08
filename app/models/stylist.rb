# frozen_string_literal: true

class Stylist < ApplicationRecord
  has_many :appointments, dependent: :restrict_with_error
  belongs_to :rank, optional: true
end
