class Item < ApplicationRecord
  has_one_attached :image
  has_one :purchase
  belongs_to :user

  validates :image, presence: {message: "を選択してください"}

  validates :user, :name, :description, :category_id, :condition_id, :carriage_payer_id, :prefecture_id, :handling_time_id, presence: true

  validates :category_id, :condition_id, :carriage_payer_id, :prefecture_id, :handling_time_id, numericality: { other_than: 1, message: "を選択してください" }
  
  with_options presence: true do
    validates :price, format: { with: /\A[0-9]+\z/, message: "が半角数字ではありません"}
  end
  
  
  validates :price, inclusion: {in: 300..9_999_999, message: "が定められた範囲ではありません"}




  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :carriage_payer
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :handling_time
end
