# frozen_string_literal: true

class CreateSaintsLegends < ActiveRecord::Migration[5.2]
  def change
    create_table :saints_legends do |t|
      t.string :siglum
      t.string :title
      t.date :date
      t.text :summary
      t.string :position
      t.string :incipit
      t.string :imev_number
      t.string :nimev_number
      t.string :dimev_number
      t.text :notes
      t.string :versification
    end
  end
end
