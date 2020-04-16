# frozen_string_literal: true

class Province < ApplicationRecord
  has_many :users

  validates :name, presence: true,
                   format: { with: /[a-zA-Z]/ }

  validates :pst, presence: true,
                  numericality: true

  validates :gst, presence: true,
                  numericality: true

  validates :hst, presence: true,
                  numericality: true
end
