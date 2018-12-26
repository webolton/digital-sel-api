# frozen_string_literal: true

# Represents a manuscript witness of a particular saint's legend
class Witness < ApplicationRecord
  belongs_to :saints_legend
  belongs_to :manuscript
end
