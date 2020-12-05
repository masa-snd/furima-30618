class Item < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_one :purchase

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to_active_hash :delivery_day
  belongs_to_active_hash :delivery_fee
  belongs_to_active_hash :prefecture

  with_options presence: true do
    validates :image, presence: { message: 'を選択してください' }
    validates :name, length: { maximum: 40 }
    validates :text, length: { maximum: 1000 }
    validates :price,
              numericality: {
                only_integer: true,
                greater_than_or_equal_to: 300,
                less_than_or_equal_to: 9_999_999
              }
  end

  validates :category_id,
            numericality: {
              other_than: 1,
              message: 'を選択してください'
            }
  validates :condition_id,
            numericality: {
              other_than: 1,
              message: 'を選択してください'
            }
  validates :delivery_fee_id,
            numericality: {
              other_than: 1,
              message: 'を選択してください'
            }
  validates :prefecture_id,
            numericality: {
              other_than: 1,
              message: 'を選択してください'
            }
  validates :delivery_day_id,
            numericality: {
              other_than: 1,
              message: 'を選択してください'
            }
end
