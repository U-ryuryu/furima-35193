class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :redirect_seller
  

  def index
  end

  def create
  end

  private

  def item_find
    @item = Item.find(params[:item_id])
  end

  def redirect_seller
    redirect_to root_path if current_user.id == @item.user.id
  end
end
