class Address < ApplicationRecord
  belongs_to :purchase
  validates :post_code, :prefecture_id, :city, :address, :phone_number, presence: true

  validates :post_code, format: {with: /\A\d{3}[-]\d{4}\z/, message: "is invalid. Include hyphen(-)"}
  validates :phone_number, format: {with: /\A\d{11}\z/ }

  validates :prefecture_id, numericality: { other_than: 1 }

end
