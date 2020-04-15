# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :card
  belongs_to :order

  def total_price
    card.price.to_i * quantity.to_i
  end
end
