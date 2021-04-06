class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @item = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    if current_user.id != @item.user.id
      redirect_to root_path
    end
  end

  def update
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_id, :status_id, :payment_id, :prefecture_id,
                                 :delivery_day_id).merge(user_id: current_user.id)
  end
end
