class Item < ApplicationRecord
  has_one_attached :image
  has_one :purchase
  with_options presence: true do
    validates :price, format: { with: /\A[0-9]+\z/}
  end
  validates :price, inclusion: {in: 300..9999999}
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :carriage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :handling_time
end
