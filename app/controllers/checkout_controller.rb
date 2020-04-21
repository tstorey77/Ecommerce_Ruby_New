# frozen_string_literal: true

class CheckoutController < ApplicationController
  def create
    # user session for current order
    session[:cart].each do |key, _value| # in shopping cart
      @products = Card.find(key.to_i)
      puts @products
      if @products.nil?
        redirect_to root_path
        return
      end
    end
    puts '----------------------------'
    puts @products.inspect
    puts ((@products.price * 100.00) / 100.00)
    puts '-----------------------------'
    # setting up a stripe session for payment
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: @products.name,
        quantity: session[:cart][@products.id.to_s],
        amount: (@products.price * 100),
        currency: 'cad'
      }],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    puts @session

    respond_to do |format|
      format.js #  render create.js.erb
    end
  end

  def success
    # create the order table and the order details
  end

  def cancel; end
end
