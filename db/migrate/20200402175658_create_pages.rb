# frozen_string_literal: true

class CreatePages < ActiveRecord::Migration[6.0]
  def change
    create_table :pages do |t|
      t.string :description
      t.string :phone
      t.string :email
      t.timestamps
    end
  end
end
