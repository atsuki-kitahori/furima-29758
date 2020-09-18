class Item < ApplicationRecord
  has_one_attached :image
  has_one :purchase
end
