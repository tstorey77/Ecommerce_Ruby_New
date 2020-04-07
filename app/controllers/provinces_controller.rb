# frozen_string_literal: true

class ProvincesController < InheritedResources::Base
  before_action :initialize_session
  before_action :load_cart

  private

  def province_params
    params.require(:province).permit(:name, :pst, :gst, :hst)
  end

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Card.find(session[:cart])
  end
end
