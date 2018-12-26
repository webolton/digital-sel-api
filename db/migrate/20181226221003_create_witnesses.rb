class CreateWitnesses < ActiveRecord::Migration[5.2]
  def change
    create_table :witnesses do |t|
      t.integer :manuscript_id
      t.integer :saints_legend_id
      t.string :position
      t.string :folios
      t.text :description
      t.text :notes
      t.string :incipit
      t.string :excipit
    end
  end
end
