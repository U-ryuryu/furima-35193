class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :redirect_user

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    @purchase_address = PurchaseAddress.new(purchase_params)
    if @purchase_address.valid?
      pay_item
      @purchase_address.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def item_find
    @item = Item.find(params[:item_id])
  end

  def redirect_user
    redirect_to root_path if current_user.id == @item.user.id || @item.purchase.present?
  end

  def purchase_params
    params.require(:purchase_address).permit(:postal_code, :city, :address, :building, :tel, :prefecture_id).merge(
      token: params[:token], user_id: current_user.id, item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @purchase_address.token,
      currency: 'jpy'
    )
  end
end
