FactoryBot.define do
  factory :item do
    name            { Faker::Coffee.blend_name }
    description     { Faker::Coffee.notes }
    price           { Faker::Number.between(from: 300, to: 9999999) }
    category_id     { Faker::Number.between(from: 2, to: 11) }
    status_id       { Faker::Number.between(from: 2, to: 7) }
    payment_id      { Faker::Number.between(from: 2, to: 3) }
    prefecture_id   { Faker::Number.between(from: 2, to: 48) }
    delivery_day_id { Faker::Number.between(from: 2, to: 4) }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
