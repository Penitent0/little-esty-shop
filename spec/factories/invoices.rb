FactoryBot.define do
  factory :invoice, class: Invoice do
    status {Faker::Number.within(range: 0..2)}
  end
end