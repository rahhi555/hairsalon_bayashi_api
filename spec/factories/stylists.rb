# frozen_string_literal: true

FactoryBot.define do
  factory :stylist do
    rank { nil }
    name { 'スタイ　リス男' }
    is_male { true }
    nickname { nil }
    hire_on { '2021-02-20' }
  end

  factory :update_stylist, class: 'Stylist' do
    rank { nil }
    name { 'スタイ　リス子' }
    is_male { false }
    nickname { 'スーパースタイリスト' }
    hire_on { '2021-02-21' }
  end
end
