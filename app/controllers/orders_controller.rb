# frozen_string_literal: true

class OrdersController < InheritedResources::Base
  before_action :initialize_session

  def show
    @order = Order.all
  end

  private

  def order_params
    params.require(:order).permit(:total_cost, :user_id, :tax)
  end
end
