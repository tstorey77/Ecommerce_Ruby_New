# frozen_string_literal: true

class PagesController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def about
    @pages = Page.all.first
  end

  private

  def initialize_session
    session[:cart] ||= []
  end

  def load_cart
    @cart = Card.find(session[:cart])
  end
end
