# frozen_string_literal: true

class AddJwtidToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :jti, :string, null: false
    add_index :users, :jti, unique: true
  end
end
