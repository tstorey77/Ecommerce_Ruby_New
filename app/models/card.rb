# frozen_string_literal: true

class Card < ApplicationRecord
  paginates_per 24

  belongs_to :category

  validates :name, presence: true, uniqueness: true
end
