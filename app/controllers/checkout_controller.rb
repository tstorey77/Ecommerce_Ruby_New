# frozen_string_literal: true

class CheckoutController < ApplicationController
  def create
    # user session for current order
    cart = session[:cart]
    products = Card.find(cart.keys)

    if products.nil?
      redirect_to root_path
      return
    end

    # get the user and province
    user = User.find(session[:user_id])
    puts user.inspect
    province = Province.find(user.province_id)

    line_items = []
    total_price = 0

    # create line items for each cart
    cart.each do |id, quantity|
      product = Card.find(id)
      line_item = {
        name: product.name,
        amount: product.price * 100,
        currency: 'cad',
        quantity: quantity
      }
      total_price += (product.price * quantity)
      line_items << line_item
    end

    # Calculate taxes
    if province.pst != 0
      pst_item = {
        name: 'PST',
        description: 'Provincial Sales Tax',
        amount: ((total_price * province.pst) * 100).round.to_i,
        currency: 'cad',
        quantity: 1
      }
      line_items << pst_item
    end

    if province.gst != 0
      gst_item = {
        name: 'GST',
        description: 'Government Sales Tax',
        amount: ((total_price * province.gst) * 100).round.to_i,
        currency: 'cad',
        quantity: 1
      }
      line_items << gst_item
    end

    if province.hst != 0
      hst_item = {
        name: 'HST',
        description: 'Harmonized Sales Tax',
        amount: ((total_price * province.hst) * 100).round.to_i,
        currency: 'cad',
        quantity: 1
      }
      line_items << hst_item
    end

    # setting up a stripe session for payment
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: line_items,
      success_url: checkout_success_url + '?session_id={CHECKOUT_SESSION_ID}',
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js #  render create.js.erb
    end
  end

  def success
    # create the order table and the order details
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end

  def cancel; end
end
