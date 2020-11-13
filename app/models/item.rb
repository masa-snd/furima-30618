class Item < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
    belongs_to :category
    belongs_to :condition
    belongs_to :delivery_day
    belongs_to :delivery_fee
    belongs_to :prefecture

end
