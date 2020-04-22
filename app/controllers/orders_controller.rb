# frozen_string_literal: true

class OrdersController < InheritedResources::Base
  before_action :initialize_session
  before_action :load_data

  def show
    @order = Order.all
  end

  private

  def load_data
    @user = current_user # get user
    province = Province.find(@user.province_id)
    @total_price = 0
    session[:cart].each do |key, value| # in shopping cart
      cards = Card.find(key.to_i)
      @total_price += (cards.price * value)
    end
    @gst = @total_price * province.gst # taxes
    @pst = @total_price * province.pst
    @hst = @total_price * province.hst
    @after_tax = @total_price + @gst + @pst + @hst # after_tax is total_price in Orders table
  end

  def order_params
    params.require(:order).permit(:total_cost, :user_id, :tax)
  end
end
