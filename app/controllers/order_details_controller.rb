# frozen_string_literal: true

class OrderDetailsController < InheritedResources::Base
  before_action :initialize_session
  before_action :load_cart

  def remove_from_details
    id = params[:id]
    session[:cart].delete(id)

    redirect_to order_details_path
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:Cards_id, :Order_id, :quantity, :price)
  end

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    items = session[:cart]
    @cart = Card.find(items.keys)
  end
end
