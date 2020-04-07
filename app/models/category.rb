# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :cards

  validates :name, presence: true, uniqueness: true
end
