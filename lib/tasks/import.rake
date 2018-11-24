# frozen_string_literal: true

require 'csv'

namespace :import do
  desc 'import data and reset db state'
  task manuscripts: :environment do
    filename = Rails.root.join('docs', 'data', 'mss-overview.csv').to_s
    CSV.foreach(filename, headers: true) do |row|
      Manuscript.create!(row.to_hash)
    end
  end
end
