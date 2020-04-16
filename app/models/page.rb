# frozen_string_literal: true

class Page < ApplicationRecord
  validates :description, presence: true,
                          format: { with: /[a-zA-Z]/ }

  validates :phone, presence: true,
                    length: { in: 7..16 }

  validates :email, presence: true,
                    length: { in: 6..64 }
end
