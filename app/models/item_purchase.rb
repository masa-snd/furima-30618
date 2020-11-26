class ItemPurchase
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number, :purchase_id, :item_id, :user_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters."}
    validates :house_number, format: { with: /\A[ぁ-んァ-ン０-９一-龥々]/, message: "is invalid. Input full-width characters."}
    validates :phone_number, format: {with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters."}
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }

  def save
    purchase = Purchase.create!(item_id: item_id , user_id: user_id)
    Address.create!(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end 