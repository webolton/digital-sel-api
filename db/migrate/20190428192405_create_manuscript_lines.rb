# frozen_string_literal: true

class CreateManuscriptLines < ActiveRecord::Migration[5.2]
  def change
    create_table :manuscript_lines do |t|
      t.text :transcribed_line
      t.text :html_line
      t.string :sel_id
      t.string :witness_line_number
      t.string :ms_line_number
      t.text :notes
      t.integer :witness_id
    end
  end
end
