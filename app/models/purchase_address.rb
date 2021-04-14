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
  end

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }

  validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/, message: 'はハイフン(-)を含む半角数字7桁で入力してください' }, if: proc { |purchase_address|
                                                                                              purchase_address.postal_code.present?
                                                                                            }

  validates :tel, numericality: { only_integer: true, message: '半角数字のみで入力してください' }, if: proc { |purchase_address|
                                                                                                                 purchase_address.tel.present?
                                                                                                               }

  validates :tel, length: { maximum: 11 }

  def save
    purchase = Purchase.create(user_id: user_id, item_id: item_id)
    ShippingAddress.create(postal_code: postal_code, city: city, address: address, building: building, tel: tel,
                           prefecture_id: prefecture_id, purchase_id: purchase.id)
  end
end
