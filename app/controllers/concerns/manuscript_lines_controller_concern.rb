# frozen_string_literal: true

module ManuscriptLinesControllerConcern
  extend ActiveSupport::Concern

  def format_line(line, notes = nil)
  def format_line(line, ms_line, notes = nil)
    if notes
      "<div id='selid-#{ms_line.witness_line_number}-msid-#{ms_line.ms_line_number}' class=''>#{annotated_line(line, notes)}</div>"
    else
      "<div id='selid-#{ms_line.witness_line_number}-msid-#{ms_line.ms_line_number}' class=''>#{line}</div>"
    end
  end

  end

  def create_marginal_note(note, witness)
    ms_line = ManuscriptLine.new
    ms_line.witness = witness
  def line_note?(line_number, note_keys)
    return true if note_keys.map{ |key| key.split('.').first }.include?(line_number)
  end

  def create_line(line, index, witness, dictionary, foliation)
    ms_line = ManuscriptLine.new
    ms_line.witness = witness
    ms_line.witness_line_number = index + 1
    ms_line.sel_id = "#{witness.manuscript.siglum}_#{witness.saints_legend.siglum}_#{ms_line.witness_line_number}"
    ms_line.transcribed_line = line
    formatted_line = line

    dictionary.to_hash.each do |abbrev|
      formatted_line.gsub!(abbrev[0], abbrev[1])
    end

    "<div>#{formatted_line}</div>"
  end
end
