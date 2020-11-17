require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '出品がうまくいくとき' do
      it 'nameとtext、categpryとcondition、delivery_feeとdelivery_day、prefectureとprice、imageが存在すれば登録できる' do
        expect(@item).to be_valid
      end
      it 'nameが40文字以内であれば登録できる' do
        @item.name = "a" * 40
        expect(@item).to be_valid
      end
      it 'textが1000文字以内であれば登録できる' do
        @item.text = "a" * 1000
        expect(@item).to be_valid
      end

    end
  end
end
