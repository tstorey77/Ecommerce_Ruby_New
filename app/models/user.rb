# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :province
  has_many :orders

  validates :province, presence: true

  validates :username, presence: true,
                       length: { in: 2..16 }

  validates :password_digest, presence: true

  validates :email, presence: true,
                    uniqueness: true,
                    length: { in: 6..64 }

  validates :address, presence: true,
                      length: { in: 5..64 }

  has_secure_password
end
