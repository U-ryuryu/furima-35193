class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to       :category
  belongs_to       :status
  belongs_to       :payment
  belongs_to       :prefecture
  belongs_to       :delivery_day
  belongs_to       :user
  has_one_attached :image

  with_options presence: true do
    validates :name 
    validates :description
    validates :price
    validates :image
  end

  with_options numericality: { other_than: 1 } do
    validates :category_id
    validates :status_id
    validates :payment_id
    validates :prefecture_id
    validates :delivery_day_id
  end
  validates :price,format: { with: /[\d]{1,}/, message: "Only half-width numbers can be entered" }, if: Proc.new {|item|item.price.present?}
  validates :price, numericality: { 
    grater_than_or_equal_to: 300, less_than: 10000000, message: "Out of the numerical range"
  }, if: Proc.new {|item|item.price.present?}

end
