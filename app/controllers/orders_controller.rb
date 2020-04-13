# frozen_string_literal: true

class OrdersController < InheritedResources::Base
  before_action :initialize_session
  before_action :load_cart

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:total_cost, :user_id)
  end

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Card.find(session[:cart])
  end
end
