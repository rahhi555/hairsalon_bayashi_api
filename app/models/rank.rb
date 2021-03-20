# frozen_string_literal: true

class Rank < ApplicationRecord
  # ランクを持っていないスタイリストもいるのでnullify(nullを許可)にする
  has_many :stylists, dependent: :nullify
  has_many :prices, dependent: :destroy
  accepts_nested_attributes_for :prices
  has_many :menus, through: :prices

  validates :name, presence: true,
                   format: { with: /\A[A-Z]\z/, message: 'ランク名はアルファベット大文字１つです' },
                   uniqueness: true
end
