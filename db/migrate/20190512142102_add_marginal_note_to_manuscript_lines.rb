# frozen_string_literal: true

class AddMarginalNoteToManuscriptLines < ActiveRecord::Migration[5.2]
  def change
    add_column :manuscript_lines, :marginal_note, :boolean, default: false
  end
end
