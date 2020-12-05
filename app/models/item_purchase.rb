class ItemPurchase
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number, :purchase_id, :item_id, :user_id, :token

  with_options presence: true do
    validates :token
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフン（-）を入力し、半角数字で入力してください' }
  end

  validates :prefecture_id, numericality: { other_than: 1, message: "を選択してください" }

  with_options presence: true do
    validates :municipality, format: { with: /\A[ぁ-んァ-ン一-龥々]/, message: 'は全角文字で入力してください' }
    validates :house_number, format: { with: /\A[ぁ-んァ-ン０-９一-龥々]/, message: 'は全角文字で入力してください' }
    validates :phone_number, format: { with: /\A[0-9]+\z/, message: 'は半角数字のみで入力してください' }
    validates :item_id
    validates :user_id
  end

  def save
    purchase = Purchase.create!(item_id: item_id, user_id: user_id)
    Address.create!(postal_code: postal_code, prefecture_id: prefecture_id, municipality: municipality, house_number: house_number, building_name: building_name, phone_number: phone_number, purchase_id: purchase.id)
  end
end
