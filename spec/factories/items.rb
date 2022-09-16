FactoryBot.define do
  factory :random_item, class: Item do
    name        {Faker::Commerce.product_name}
    description {Faker::Marketing.buzzwords}
    unit_price  {Faker::Number.within(range: 500..2000)}
    association :merchant, factory: :random_merchant
  end
end

before(:each) do
  merchant_1 = create(:random_merchant)

  item_1 = create(:random_item, merchant: merchant_1)
  invoice_1 = create(:randon_invoice)

  item_1.invoice_items << invoice_1
end