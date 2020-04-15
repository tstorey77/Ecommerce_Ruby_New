# frozen_string_literal: true

class OrdersController < InheritedResources::Base
  before_action :initialize_session
  before_action :load_cart
  before_action :load_data

  def index; end

  def show
    # @order = Order.find(params[:id])
  end

  def confirm
    # create order and then create the order_details to connect
    puts '************************$$$$$'
    puts @total_price
    puts @pst
    puts @gst
    puts @hst
    puts @after_tax
    puts @user.inspect
    @order = @user.order.create(total_price: @after_tax,
                                gst: @gst,
                                pst: @pst,
                                hst: @hst,
                                users_id: @user.id)

    puts @order.inspect
  end

  private

  def load_data
    @user = current_user
    province = Province.find(@user.province_id)
    @total_price = 0
    session[:cart].each do |key, value|
      cards = Card.find(key.to_i)
      @total_price += (cards.price * value)
    end
    @gst = @total_price * province.gst
    @pst = @total_price * province.pst
    @hst = @total_price * province.hst
    @after_tax = @total_price + @gst + @pst + @hst
  end

  def order_params
    params.require(:order).permit(:total_cost, :user_id, :tax)
  end
end
