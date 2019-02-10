# frozen_string_literal: true

class SaintsLegend < ApplicationRecord
  has_many :witnesses, dependent: :restrict_with_exception
  has_many :manuscripts, through: :witnesses
end
