# frozen_string_literal: true

class ChangeManuscriptUrlColumns < ActiveRecord::Migration[5.2]
  def change
    add_column :manuscripts, :digital_edition_url, :string
    rename_column :manuscripts, :url, :catalog_url
  end
end
