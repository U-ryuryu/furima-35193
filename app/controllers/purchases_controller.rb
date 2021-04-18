class PurchasesController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find
  before_action :redirect_user

  def index
    @purchase_address = PurchaseAddress.new
  end

  def create
    if current_user.card.blank?
      @purchase_address = PurchaseAddress.new(purchase_params)
      if @purchase_address.valid?
        pay_item
        @purchase_address.save
        redirect_to root_path
      else
        render :index
      end
    else
      @purchase_address = PurchaseAddress.new(address_params)
      if @purchase_address.valid?
        pay_card_item
        @purchase_address.save
        redirect_to root_path
      else
        render :index
      end
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

  def address_params
    params.require(:purchase_address).permit(:postal_code, :city, :address, :building, :tel, :prefecture_id).merge(token: "aaa",user_id: current_user.id, item_id: params[:item_id]
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

  def pay_card_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    customer_token = current_user.card.customer_token
    Payjp::Charge.create(
      amount: @item.price,  
      customer: customer_token, 
      currency: 'jpy' 
    )
  end
end
