FactoryBot.define do
  factory :merchant_1, class: Merchant do
    name {"Amazing Appliances"}
  end

  factory :merchant_2, class: Merchant do
    name {"Cool Clothes"}
  end

  factory :merchant_3, class: Merchant do
    name {"Super Sofas"}
  end

  factory :random_merchant, class: Merchant do
    name {Faker::Name.name}
  end
end