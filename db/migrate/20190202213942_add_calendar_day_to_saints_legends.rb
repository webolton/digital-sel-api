# frozen_string_literal: true

class AddCalendarDayToSaintsLegends < ActiveRecord::Migration[5.2]
  def change
    add_column :saints_legends, :calendar_day, :string
  end
end
