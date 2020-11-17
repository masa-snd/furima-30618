class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :image
    validates :name, length: { maximum: 40 }
    validates :text, length: { maximum: 1000 }
    validates :price,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9_999_999,
              }
  end

  validates :category_id,
              numericality: {
                other_than: 1,
                message: 'カテゴリーを選択してください'
              }
  validates :condition_id,
              numericality: {
                other_than: 1,
                message: '商品の状態を選択してください'
              }
  validates :delivery_fee_id,
              numericality: {
                other_than: 1,
                message: '配送料の負担を選択してください'
              }
  validates :prefecture_id,
              numericality: {
                other_than: 1,
                message: '発送元の地域を選択してください'
              }
  validates :delivery_day_id,
              numericality: {
                other_than: 1,
                message: '発送までの日数を選択してください'
              }
end
