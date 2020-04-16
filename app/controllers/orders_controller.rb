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
    curr_user = User.find(@user.id)
    @order = curr_user.orders.create(total_cost: @after_tax.to_s,
                                     gst: @gst,
                                     pst: @pst,
                                     hst: @hst,
                                     user_id: @user.id)

    puts @order.inspect
    # works -- now create the order_details
    session[:cart].each do |key, value|
      card = Card.find(key)
      @order_details = OrderDetail.create(quantity: value,
                                          price: card.price,
                                          card: card,
                                          order: @order)
    end
    # now we should redirect to payment page -- ** do above after stripe confirmation
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
