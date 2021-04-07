class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :redirect_seller
  

  def index
    @purchase = Purchase.new
  end

  def create
    # @purchase = Purchase.new(purchase_params)  formオブジェクト追加後実装
    # if @purchase.valid?   formオブジェクト追加後実装
      pay_item
      # @purchase.save    formオブジェクト追加後実装 return
      redirect_to root_path
    # else
    #   render 'index'   formオブジェクト追加後実装
    # end
  end

  private

  def item_find
    @item = Item.find(params[:item_id])
  end

  def redirect_seller
    redirect_to root_path if current_user.id == @item.user.id
  end

  def purchase_params
    params.permit(:token, :item_id).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end
