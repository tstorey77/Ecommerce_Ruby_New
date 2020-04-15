# frozen_string_literal: true

class AddTaxesToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :pst, :string
    add_column :orders, :gst, :string
    add_column :orders, :hst, :string
  end
end
