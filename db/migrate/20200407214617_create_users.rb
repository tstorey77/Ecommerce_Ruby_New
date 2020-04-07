# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :email
      t.string :address
      t.references :province, null: false, foreign_key: true

      t.timestamps
    end
  end
end
