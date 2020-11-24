class PurchasesController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @item_purchase = ItemPurchase.new
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    @item = Item.find(params[:item_id])
    # binding.pry
    if @item_purchase.valid?
      @item_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def purchase_params
    params.require(:item_purchase).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number, :purchase_id, :item_id, :user_id)
  end
end