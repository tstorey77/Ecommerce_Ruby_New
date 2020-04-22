class AddStripeIdToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :stripeId, :string
  end
end
