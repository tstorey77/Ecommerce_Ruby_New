# frozen_string_literal: true

json.extract! order, :id, :created_at, :updated_at
json.url cart_url(order, format: :json)
