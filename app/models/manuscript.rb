# frozen_string_literal: true

class Manuscript < ApplicationRecord
  has_many :witnesses, dependent: :restrict_with_exception
  has_many :saints_legends, through: :witnesses
end
