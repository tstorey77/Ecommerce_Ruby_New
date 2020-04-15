# frozen_string_literal: true

class OrderDetailsController < InheritedResources::Base
  before_action :initialize_session
  before_action :load_cart

  def remove_from_details
    id = params[:id]
    session[:cart].delete(id)

    redirect_to review_cart_path
  end

  def add_quantity
    session[:cart].each do |key, value|
      new_value = value + 1
      if key == params[:id]
        new_hash = { key => new_value }
        session[:cart].merge!(new_hash)
      end
    end
    redirect_to review_cart_path
  end

  def minus_quantity
    session[:cart].each do |key, value|
      new_value = value - 1
      if key == params[:id]
        if new_value == 0
          remove_from_details
          return
        else
          new_hash = { key => new_value }
          session[:cart].merge!(new_hash)
        end
      end
    end
    redirect_to review_cart_path
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
