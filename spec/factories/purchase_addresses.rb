FactoryBot.define do
  factory :purchase_address do
    token         { Faker::Internet.password }
    postal_code   { Faker::Number.number(digits: 7).to_s.insert(3, '-') }
    city          { Faker::Address.city }
    address       { Faker::Address.street_address }
    building      { Faker::Address.building_number}
    tel           { Faker::Number.between(from: 1, to: 99_999_999_999) }
    prefecture_id { Faker::Number.between(from: 2, to: 48) }
  end
end
