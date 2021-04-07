class PurchaseAddress
  include ActiveModel::Model
  attr_accessor :token, :user_id, :item_id, :postal_code, :city, :address, :building, :tel, :prefecture_id, :purchase_id

  with_options presence: true do
    validates :token
    validates :user_id
    validates :item_id
    validates :postal_code
    validates :city
    validates :address
    validates :tel
    validates :purchase_id
  end

  validates :prefecture_id, numericality: {other_than: 1, message: 'please select other than "---"'}

  with_options if: proc { |purchase_address| purchase_address.postal_code.present? } do
    validates :postal_code format: { with: /\A\d{3}[-]\d{4}\z/, message: 'requires "-"'}

    validates :tel namericality: {only_integer: true, message: 'only half-width numbers can be entered'}

    validates :tel length: { maxmum: 11}
  end

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, city: city, address: address, building: building, tel: tel, prefecture_id: prefecture_id, purchase_id: purchase.id)
  end
end