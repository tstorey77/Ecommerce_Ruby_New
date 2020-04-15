# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?
  before_action :initialize_session
  before_action :load_cart

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    else
      @current_user = nil
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def authorized
    redirect_to '/welcome' unless logged_in?
  end

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    items = session[:cart]
    @cart = Card.find(items.keys)
  end
end
