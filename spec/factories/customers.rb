FactoryBot.define do
  factory :customer do
    name { "田中　太郎" }
    tel { "09088887777" }
    mail { "mail@example.com" }
  end

  factory :invalid_customer, class: Customer do
    name { "" }
    tel  { "" }
    mail { "" }
  end

  factory :update_customer, class: Customer do
    name { "田中　次郎"}
    tel  { "09088886666" }
    mail { "mail@ezweb.ne.jp" }
  end

  factory :invalid_customers, class: Customer do
    name { "田中　三郎" }
    tel  { "09088885555" }
    mail { "mail@yahoo.co.jp" }

    trait :name_not_null do
      name { "" }
    end

    trait :name_fifty_over do
      name { "aaaaaaaaaaaaaaaaaaaaaaa　aaaaaaaaaaaaaaaaaaaaaaaaaaa" }
    end

    trait :name_not_space do
      name { "田中三郎" }
    end

    trait :name_top_space do
      name { " 田中三郎" }
    end

    trait :name_end_space do
      name { "田中三郎 "}
    end

    trait :tel_not_number do
      name { "aaaaaaaaaa" }
    end

    trait :tel_over_eleven do
      name { "11111111111" }
    end

    trait :mail_no_atmark do
      name { "mailyahoo.co.jp" }
    end
  end
end
