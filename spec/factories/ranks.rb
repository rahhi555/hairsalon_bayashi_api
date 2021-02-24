# frozen_string_literal: true

FactoryBot.define do
  factory :rank do
    name { 'C' }
  end

  factory :invalid_rank, class: 'Rank' do
    name { '' }
  end
end
