# frozen_string_literal: true

class AddTranscribedToWitnesses < ActiveRecord::Migration[5.2]
  def change
    add_column :witnesses, :transcribed, :boolean, default: false
  end
end
