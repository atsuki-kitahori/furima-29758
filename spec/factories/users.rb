FactoryBot.define do
  factory :user do
    nickname { Faker::Name }
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 6) }
    password_confirmation { password }
    first_name { '多ろウ' }
    family_name { 'す図キ' }
    first_name_kana { 'タロウ' }
    family_name_kana { 'スズキ' }
    birth_date { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
