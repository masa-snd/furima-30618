class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_root_path

  def index
    @item = Item.find(params[:item_id])
    @item_purchase = ItemPurchase.new
  end

  def create
    @item_purchase = ItemPurchase.new(purchase_params)
    @item = Item.find(params[:item_id])
    if @item_purchase.valid?
      pay_item
      @item_purchase.save
      redirect_to root_path
    else
      render action: :index
    end
  end

  private
  def purchase_params
    params.require(:item_purchase).permit(:postal_code, :prefecture_id, :municipality, :house_number, :building_name, :phone_number).merge(purchase_id: params[:purchase_id], item_id: params[:item_id], user_id: current_user.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price,
        card: purchase_params[:token],
        currency: 'jpy'
      )
  end

  def move_to_root_path
    @item = Item.find(params[:item_id])
    if @item.user_id == current_user.id
      redirect_to root_path
    end
  end
end