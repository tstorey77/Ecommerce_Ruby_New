# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_details

  def index
    @orders = Order.all
  end

  def add_card(card)
    current_item = order_details.find_by(id: card.id)
    if current_item
      current_item.increment(:quantity)
    else
      current_item = order_details.build(id: card.id)
    end
    current_item
  end

  def total_price
    order_details.to_a.sum(&:total_price)
  end
end
