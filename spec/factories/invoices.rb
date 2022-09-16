FactoryBot.define do
  factory :random_invoice, class: Invoice do
    status {Faker::Number.within(range: 0..2)}
  end
end