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
        @item.name = "a" * 40
        expect(@item).to be_valid
      end
      it 'textが1000文字以内であれば出品できる' do
        @item.text = "a" * 1000
        expect(@item).to be_valid
      end
    end

    context "出品がうまくいかないとき" do
      it "nameが空では出品できない" do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end     
      it "nameが41文字以上では出品できない" do
        @item.name = "a" * 41
        @item.valid?
        expect(@item.errors.full_messages).to include("Name is too long (maximum is 40 characters)")
      end
    end
  end
end
