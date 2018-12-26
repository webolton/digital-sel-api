# frozen_string_literal: true

class SaintsLegend < ApplicationRecord
  has_many :witnesses
  has_many :manuscripts, through: :witnesses
end
