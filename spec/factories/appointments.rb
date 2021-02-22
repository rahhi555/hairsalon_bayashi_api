FactoryBot.define do
  factory :appointment do
    customer { nil }
    appointment_on { "2021-02-20 18:39:00" }
    remark { "MyText" }
  end
end
