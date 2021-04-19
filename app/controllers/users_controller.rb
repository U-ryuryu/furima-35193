class UsersController < ApplicationController
  before_action :user_find, only: [:edit, :update, :destroy]
  def show
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    card = Card.find_by(user_id: current_user.id)
    if card.present?
      customer = Payjp::Customer.retrieve(card.customer_token)
      @card = customer.cards.first
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to root_path
    else
      redirect_to action: "edit"
    end
  end
  private

  def user_params
    params.require(:user).permit(:nickname, :email, :last_name, :first_name, :read_last_name, :read_first_name, :birthday)
  end

  def user_find
    @user = User.find(params[:id])
  end
end
