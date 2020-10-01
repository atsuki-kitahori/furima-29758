class PurchasesController < ApplicationController
  before_action :set_item
  def index
    if  
      @item.purchase != nil
      redirect_to root_path
    end
  end

  def create
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      return redirect_to root_path
    else
      render 'index'
    end
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def purchase_params
    params.permit(:post_code, :prefecture_id, :city, :address, :building_name, :phone_number, :user_id, :item_id, :token).merge(user_id: current_user.id, item_id: @item.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end

end
