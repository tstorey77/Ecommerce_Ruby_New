# frozen_string_literal: true

class Order < ApplicationRecord
  has_many :order_details

  validates :total_cost, presence: true,
                         length: { in: 1..100_000 }

  validates :user_id, presence: true

  validates :pst, presence: true,
                  numericality: true

  validates :gst, presence: true,
                  numericality: true

  validates :hst, presence: true,
                  numericality: true
end
