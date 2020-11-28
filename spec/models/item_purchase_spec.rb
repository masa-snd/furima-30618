require 'rails_helper'

RSpec.describe ItemPurchase, type: :model do
  before do
    @item_purchase = FactoryBot.build(:item_purchase)
  end

  describe '商品購入機能' do
    context '購入がうまくいくとき' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@item_purchase).to be_valid
      end
      it '建物名が空でも購入できる' do
        @item_purchase.building_name = ''
        expect(@item_purchase).to be_valid
      end
    end

    context '購入がうまくいかないとき' do
      it 'postal_codeが空では購入できない' do
        @item_purchase.postal_code = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeに(-)が含まれてないと購入できない' do
        @item_purchase.postal_code = '1111111'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-) or input half-width characters.')
      end
      it 'postal_codeが全角数字では購入できない' do
        @item_purchase.postal_code = '１１１−１１１１'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('Postal code is invalid. Include hyphen(-) or input half-width characters.')
      end
      it 'prefectureが---のままでは購入できない' do
        @item_purchase.prefecture_id = 1
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Prefecture can't be blank")
      end
      it 'municipalityが空では購入できない' do
        @item_purchase.municipality = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Municipality can't be blank")
      end
      it 'municipalityに半角英数が含まれていると購入できない' do
        @item_purchase.municipality = 'abc123'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('Municipality is invalid. Input full-width characters.')
      end
      it 'house_numberが空では購入できない' do
        @item_purchase.house_number = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("House number can't be blank")
      end
      it 'house_numberに英数が含まれていると半角では購入できない' do
        @item_purchase.house_number = 'a1-1-1'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('House number is invalid. Input full-width characters.')
      end
      it 'phone_numberが空では購入できない' do
        @item_purchase.phone_number = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Phone number can't be blank")
      end
      it 'phone_numberが全角数字では購入できない' do
        @item_purchase.phone_number = '０９０１２３４５６７８'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('Phone number is invalid. Input only number or input half-width characters.')
      end
      it 'phone_numberに(-)が含まれていると購入できない' do
        @item_purchase.phone_number = '0120111-111'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('Phone number is invalid. Input only number or input half-width characters.')
      end
      it 'tokenが空では購入できない' do
        @item_purchase.token = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
