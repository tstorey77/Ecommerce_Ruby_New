# frozen_string_literal: true

class CategoriesController < InheritedResources::Base
  before_action :initialize_session
  before_action :load_cart

  def index
    @category = Category.all
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Card.find(session[:cart])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
