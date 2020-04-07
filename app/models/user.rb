# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :provinces

  has_secure_password
end
