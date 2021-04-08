FactoryBot.define do
  factory :user do
    transient do
      person { Gimei.name }
    end
    nickname              { Faker::Name.name }
    email                 { Faker::Internet.free_email }
    password = '1a' + Faker::Internet.password(min_length: 4)
    password              { password }
    password_confirmation { password }
    last_name             { person.last.kanji }
    first_name            { person.first.kanji }
    read_last_name        { person.last.katakana }
    read_first_name       { person.first.katakana }
    birthday              { Faker::Date.backward }
  end
end
