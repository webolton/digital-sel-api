# frozen_string_literal: true

class CreateManuscripts < ActiveRecord::Migration[5.2]
  def change
    create_table :manuscripts do |t|
      t.string :shelfmark
      t.string :siglum
      t.string :country
      t.string :city
      t.string :repository
      t.date :date
      t.text :description
      t.text :dialect
      t.text :scribal_description
      t.text :provenance
      t.string :url
      t.string :sc_number
      t.text :notes
      t.string :status
      t.string :owned
      t.float :price
      t.boolean :major_ms
    end
  end
end
