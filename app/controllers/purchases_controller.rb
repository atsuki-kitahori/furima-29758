class PurchasesController < ApplicationController
  before_action :set_item
  def index
    @purchase = UserPurchase.new
    redirect_to root_path unless @item.purchase.nil?
    if user_signed_in? && current_user.id == @item.user_id
      redirect_to root_path
    end
  end

  def create
    @purchase = UserPurchase.new(purchase_params)
    if @purchase.valid?
      pay_item
      @purchase.save
      redirect_to root_path
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
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: purchase_params[:token],
      currency: 'jpy'
    )
  end
end
