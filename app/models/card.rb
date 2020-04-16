# frozen_string_literal: true

class Card < ApplicationRecord
  paginates_per 24

  belongs_to :category
  has_many :order_details

  validates :name, presence: true,
                   uniqueness: true

  validates :description, presence: true,
                          length: { in: 2..65_536 }

  validates :attack, numericality: true

  validates :defence, numericality: true

  validates :price, numericality: true
end
