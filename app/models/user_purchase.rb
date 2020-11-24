class UserPurchase
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :municipality, :house_number, :building_name, :phone_number, :item, :user
end