class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)\w{6,100}\z/.freeze
  validates :password, format: { with: VALID_PASSWORD_REGEX, message: '半角英数字混合で入力してください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥々]+\z/, message: '全角（漢字・ひらがな・カタカナ）文字を使用してください' } do
    validates :family_name, presence: true
    validates :first_name, presence: true
  end

  with_options presence: true, format: { with: /\A[ァ-ヶー－]+\z/, message: '全角（カタカナ）文字を使用してください' } do
    validates :family_name_kana, presence: true
    validates :first_name_kana, presence: true
  end

  validates :birthday, presence: true
end
