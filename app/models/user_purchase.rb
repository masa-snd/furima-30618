class UserPurchase
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :municipality, :house_number, :building_name, :phone_number, :purchase, :item, :user

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :municipality, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: "is invalid. Input full-width characters."}
    validates :house_number, format: { with: /\A[ぁ-んァ-ン０-９一-龥々]/, message: "is invalid. Input full-width characters."}
    validates :postal_code, format: {with: /\A[0-9]+\z/, message: "is invalid. Input half-width characters."}
  end

  validates :prefecture, numericality: { other_than: 1, message: "can't be blank" }

  def save
    Address.create(postal_code: postal_code, prefecture: prefecture, municipality: municipality, house_number: house_number, building_name: building_name,purchase_id: purchase.id)
    Purchase.create(item_id: item.id , user_id: user.id)
  end
end