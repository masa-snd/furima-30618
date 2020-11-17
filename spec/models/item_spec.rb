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
      it "textが空では出品できない" do
        @item.text = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("Text can't be blank")
      end     
      it "textが1001文字以上では出品できない" do
        @item.text = "a" * 1001
        @item.valid?
        expect(@item.errors.full_messages).to include("Text is too long (maximum is 1000 characters)")
      end
      it "categoryが---のままでは出品できない" do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end     
      it "conditionが---のままでは出品できない" do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Condition must be other than 1")
      end     
      it "delivery_feeが---のままでは出品できない" do
        @item.delivery_fee_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery fee must be other than 1")
      end     
      it "prefectureが---のままでは出品できない" do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture must be other than 1")
      end     
      it "delivery_dayが---のままでは出品できない" do
        @item.delivery_day_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery day must be other than 1")
      end     
    end
  end
end
