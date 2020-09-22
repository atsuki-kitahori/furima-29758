FactoryBot.define do
  factory :item do
    association :user # associationを使用してあげる方法
    image{Faker::Lorem.sentence}
    name{'yasai'}
    description{'yasai'}
    category_id{2}
    condition_id{2}
    carriage_payer_id{2}
    prefecture_id{2}
    handling_time_id{2}
    price{500}
    # imageをつけてあげる方法
    # chat-app rspecカリキュラム
  end
end
