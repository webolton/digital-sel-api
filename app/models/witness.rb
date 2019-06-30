# frozen_string_literal: true

# Represents a manuscript witness of a particular saint's legend
class Witness < ApplicationRecord
  belongs_to :saints_legend
  belongs_to :manuscript

  validates :saints_legend, presence: true
  validates :manuscript, presence: true

  attr_reader :ms_siglum, :sl_siglum

  def self.for_ms_and_siglum(ms_id_or_siglum, siglum)
    if ms_id_or_siglum.is_a?(Integer)
      where(manuscript_id: ms_id_or_siglum).joins(:saints_legend).find_by('saints_legends.siglum = ?', siglum)
    else
      joins(:manuscript).where('manuscripts.siglum = ?', ms_id_or_siglum)
                        .joins(:saints_legend).find_by('saints_legends.siglum = ?', siglum)
    end
  end

  def ms_siglum
    manuscript.siglum
  end

  def sl_siglum
    saints_legend.siglum
  end
end
