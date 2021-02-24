# frozen_string_literal: true

FactoryBot.define do
  factory :appointment do
    appointment_on { '2021-02-20 18:39:00' }
    remark { 'MyText' }
  end

  factory :invalid_appointment, class: 'Appointment' do
    customer_id { '' }
    stylist_id { '' }
    appointment_on { '2021-02-20 18:39:00' }
    remark { 'MyText' }
  end

  factory :update_appointment, class: 'Appointment' do
    appointment_on { '2021-12-24 15:00:00' }
    remark { 'ChangeText' }
  end
end
