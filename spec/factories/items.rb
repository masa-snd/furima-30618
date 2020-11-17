FactoryBot.define do
  factory :item do
    name                 { Faker::Commerce.product_name }
    text                 { Faker::Lorem.sentence }
    category             {  }
    condition            {  }
    delivery_fee         {  }
    prefecture           {  }
    delivery_day         {  }
    price                { Faker::Number.between(from: 300, to: 9999999) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/item_sample.png'), filename: 'item_sample.png')
    end
  end
end
