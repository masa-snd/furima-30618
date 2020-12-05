require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品がうまくいくとき' do
      it 'nameとtext、categpryとcondition、delivery_feeとdelivery_day、prefectureとprice、imageが存在すれば出品できる' do
        expect(@item).to be_valid
      end
      it 'nameが40文字以内であれば出品できる' do
        @item.name = 'a' * 40
        expect(@item).to be_valid
      end
      it 'textが1000文字以内であれば出品できる' do
        @item.text = 'a' * 1000
        expect(@item).to be_valid
      end
    end

    context '出品がうまくいかないとき' do
      it 'nameが空では出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'nameが41文字以上では出品できない' do
        @item.name = 'a' * 41
        @item.valid?
        expect(@item.errors.full_messages).to include('商品名は40文字以内で入力してください')
      end
      it 'textが空では出品できない' do
        @item.text = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明を入力してください')
      end
      it 'textが1001文字以上では出品できない' do
        @item.text = 'a' * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の説明は1000文字以内で入力してください')
      end
      it 'categoryが---のままでは出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'conditionが---のままでは出品できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'delivery_feeが---のままでは出品できない' do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'prefectureが---のままでは出品できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'delivery_dayが---のままでは出品できない' do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'priceが空では出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください", "価格は数値で入力してください")
      end
      it 'priceの範囲が、¥299以下では出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は300以上の値にしてください')
      end
      it 'priceの範囲が、¥10,000,000以上では出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('価格は9999999以下の値にしてください')
      end
      it 'imageが空では出品できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("出品画像を選択してください")
      end
    end
  end
end
