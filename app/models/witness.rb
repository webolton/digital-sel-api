# frozen_string_literal: true

# Represents a manuscript witness of a particular saint's legend
class Witness < ApplicationRecord
  belongs_to :saints_legend
  belongs_to :manuscript

  scope :for_ms_and_siglum, ->(ms_id, siglum) {
    where(manuscript_id: ms_id).joins(:saints_legend).where("saints_legends.siglum = ?", siglum).first
  }
end
