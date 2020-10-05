class UserPurchase
  include ActiveModel::Model 
  attr_accessor :post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token

  validates :post_code, :prefecture_id, :city, :address, :phone_number, presence: true

  validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :phone_number, format: {with: /\A\d{11}\z/ }

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    Address.create(post_code: post_code, prefecture_id: prefecture_id, city: city, address: address, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id )

  end

end