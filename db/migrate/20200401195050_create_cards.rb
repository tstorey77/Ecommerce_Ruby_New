class CreateCards < ActiveRecord::Migration[6.0]
  def change
    create_table :cards do |t|
      t.string :name
      t.string :card_type
      t.string :description
      t.integer :attack
      t.integer :defence
      t.integer :price

      t.timestamps
    end
  end
end
