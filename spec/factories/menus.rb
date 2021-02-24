# frozen_string_literal: true

FactoryBot.define do
  factory :menu do
    name { 'カット' }
    code { 'K' }
    time { '00:30:00' }
  end

  factory :invalid_menu, class: 'Menu' do
    name { '' }
    code { '' }
    time { '' }
  end

  factory :update_menu, class: 'Menu' do
    name { 'スーパーカット' }
    code { 'Z' }
    time { '00:50:00' }
  end
end
