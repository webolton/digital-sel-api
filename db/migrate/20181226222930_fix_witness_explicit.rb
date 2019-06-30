# frozen_string_literal: true

class FixWitnessExplicit < ActiveRecord::Migration[5.2]
  def change
    rename_column :witnesses, :excipit, :explicit
  end
end
