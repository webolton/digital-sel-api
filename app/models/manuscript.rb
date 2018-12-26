# frozen_string_literal: true

class Manuscript < ApplicationRecord
  has_many :witnesses
  has_many :saints_legends, through: :witnesses
end
