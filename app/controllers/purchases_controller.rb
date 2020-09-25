class PurchasesController < ApplicationController
  before_action :set_item
  def index
    @items = Item.all
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

end
