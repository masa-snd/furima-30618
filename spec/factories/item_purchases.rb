FactoryBot.define do
  factory :item_purchase do
    token {"tok_abcdefghijk00000000000000000"}
    postal_code { "111-1111" }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
    municipality { Gimei.address.city.kanji }
    house_number { Gimei.address.town.kanji + '１−１−１' }
    building_name { "ハイツ１０１" }
    phone_number { Faker::Number.leading_zero_number(digits: 11) }
    association :user
    association :item
  end
end
