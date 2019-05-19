# frozen_string_literal: true

class ManuscriptLine < ApplicationRecord
  belongs_to :witness

  validates :witness, presence: true
  validates :sel_id, uniqueness: true
  validates :ms_line_number, uniqueness: true
end
