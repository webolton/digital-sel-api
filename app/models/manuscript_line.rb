# frozen_string_literal: true

class ManuscriptLine < ApplicationRecord
  belongs_to :witness

  validates :witness, presence: true
end
