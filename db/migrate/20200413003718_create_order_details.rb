# frozen_string_literal: true

class CreateOrderDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :order_details do |t|
      t.integer :quantity, default: 1
      t.integer :price
      t.references :cards, null: false, foreign_key: true
      t.references :orders, null: false, foreign_key: true

      t.timestamps
    end
  end
end
