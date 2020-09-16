FactoryBot.define do
  factory :user do
    nickname { Faker::Name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name { Faker::Name }
    family_name { Faker::Name }
    first_name_kana { Faker::Name }
    family_name_kana { Faker::Name }
    birth_date {Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
