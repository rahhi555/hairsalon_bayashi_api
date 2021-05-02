# frozen_string_literal: true

FactoryBot.define do
  factory :stylist do
    name { 'スタイ　リス男' }
    is_male { true }
    nickname { nil }
    hire_on { '2021-02-20' }
    tel { '0312456795' }
    mail { 'stylist1@example.com' }
    uid { 'stylistuid1' }
  end

  factory :update_stylist, class: 'Stylist' do
    name { 'スタイ　リス子' }
    is_male { false }
    nickname { 'スーパースタイリスト' }
    hire_on { '2021-02-21' }
    tel { '0245679815' }
    mail { 'stylist2@example.com' }
    uid { 'stylistuid2' }
  end

  factory :invalid_stylist, class: 'Stylist' do
    name { '' }
    is_male { true }
    nickname { '' }
    hire_on { '' }
    tel { '' }
    mail { '' }
    uid { '' }
  end
end
