# frozen_string_literal: true

class OrderDetail < ApplicationRecord
  belongs_to :card
  belongs_to :order

  validates :card, presence: true
  validates :order, presence: true

  validates :quantity, presence: true,
                       numericality: true

  validates :price,  presence: true,
                     numericality: true
end
