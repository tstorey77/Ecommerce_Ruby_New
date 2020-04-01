# frozen_string_literal: true

class Card < ApplicationRecord
  paginates_per 24

  validates :name, presence: true, uniqueness: true
  validates :card_type, presence: true
end
