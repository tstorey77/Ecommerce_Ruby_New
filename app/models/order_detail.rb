# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  has_many :cards
  belongs_to :orders

  def total_price
    card.price.to_i * quantity.to_i
  end
end
