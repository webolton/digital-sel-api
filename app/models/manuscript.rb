# frozen_string_literal: true

class Manuscript < ApplicationRecord
  has_many :witnesses, dependent: :restrict_with_exception
  has_many :saints_legends, through: :witnesses

  def witness_count
    witnesses.count
  end

  #  TODO: this method should return a likely date range based on the date data type. There will
  #  likely need to be some logic / rules about date entry that will indicate whether a MS is from
  #  a particular part of the century.
  def date_range
    nil
  end
end
