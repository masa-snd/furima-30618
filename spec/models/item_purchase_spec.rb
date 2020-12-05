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
        expect(@item_purchase.errors.full_messages).to include("郵便番号を入力してください", "郵便番号はハイフン（-）を入力し、半角数字で入力してください")
      end
      it 'postal_codeに(-)が含まれてないと購入できない' do
        @item_purchase.postal_code = '1111111'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('郵便番号はハイフン（-）を入力し、半角数字で入力してください')
      end
      it 'postal_codeが全角数字では購入できない' do
        @item_purchase.postal_code = '１１１−１１１１'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('郵便番号はハイフン（-）を入力し、半角数字で入力してください')
      end
      it 'prefectureが---のままでは購入できない' do
        @item_purchase.prefecture_id = 1
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("都道府県を選択してください")
      end
      it 'municipalityが空では購入できない' do
        @item_purchase.municipality = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("市区町村を入力してください", "市区町村は全角文字で入力してください")
      end
      it 'municipalityに半角英数が含まれていると購入できない' do
        @item_purchase.municipality = 'abc123'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('市区町村は全角文字で入力してください')
      end
      it 'house_numberが空では購入できない' do
        @item_purchase.house_number = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("番地を入力してください", "番地は全角文字で入力してください")
      end
      it 'house_numberに英数が含まれていると半角では購入できない' do
        @item_purchase.house_number = 'a1-1-1'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('番地は全角文字で入力してください')
      end
      it 'phone_numberが空では購入できない' do
        @item_purchase.phone_number = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("電話番号を入力してください", "電話番号は半角数字のみで入力してください")
      end
      it 'phone_numberが全角数字では購入できない' do
        @item_purchase.phone_number = '０９０１２３４５６７８'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end
      it 'phone_numberに(-)が含まれていると購入できない' do
        @item_purchase.phone_number = '0120111-111'
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include('電話番号は半角数字のみで入力してください')
      end
      it 'tokenが空では購入できない' do
        @item_purchase.token = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("クレジットカード情報を入力してください")
      end
      it '商品IDが空の場合購入できない' do
        @item_purchase.user_id = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Userを入力してください")
      end
      it 'ユーザーIDが空の場合購入できない' do
        @item_purchase.item_id = ''
        @item_purchase.valid?
        expect(@item_purchase.errors.full_messages).to include("Itemを入力してください")
      end
    end
  end
end
