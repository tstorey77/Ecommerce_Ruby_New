# frozen_string_literal: true

class Card < ApplicationRecord
  paginates_per 24

  belongs_to :category
  has_many :order_details

  validates :name, presence: true, uniqueness: true
end
