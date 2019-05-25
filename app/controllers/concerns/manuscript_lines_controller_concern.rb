# frozen_string_literal: true

module ManuscriptLinesControllerConcern
  extend ActiveSupport::Concern

  def annotated_line_and_notes(line, line_number, notes, sel_id)
    words = line.split(' ')
    notes = notes_for_line(line_number, notes)
    note_text = []
    notes.each do |key, val|
      note_index = key.split('.').last.to_i - 1
      annotated_word = words[note_index]
      words[note_index] = "<span class='annotated-word' id='note-#{sel_id}-#{note_index}'>#{annotated_word}</span>"
      note_text.push(val)
    end
    [words.join(' '), note_text.join(' ')]
  end

  def format_line(line, ms_line, notes = nil)
    if notes
      "<div id='selid-#{ms_line.witness_line_number}-msid-#{ms_line.ms_line_number}' class=''>" \
      "#{annotated_line(line, notes)}</div>"
    else
      "<div id='selid-#{ms_line.witness_line_number}-msid-#{ms_line.ms_line_number}' class=''>#{line}</div>"
    end
  end

  def create_manuscript_line_number(sel_line_number, foliation, note = false)
    foliation.each do |range_string, folio|
      range = range_string.split('..').inject{ |st_range, end_range| st_range.to_i..end_range.to_i }
      if range.include?(sel_line_number.to_i)
        folio_line_no = range.find_index(sel_line_number.to_i) + 1
        note ? "#{folio}-#{folio_line_no}-marginal-note" : "#{folio}-#{folio_line_no}"
      end
    end
  end

  def create_marginal_note(key, _value, witness, foliation)
    ms_line = ManuscriptLine.new
    ms_line.witness = witness
    ms_line.witness_line_number = key.split('.').first
    ms_line.sel_id = "#{witness.manuscript.siglum}-#{witness.saints_legend.siglum}-#{ms_line.witness_line_number}"
    ms_line.marginal_note = true
    ms_line.ms_line_number = create_manuscript_line_number(ms_line.witness_line_number, foliation, true)
    if ms_line.save
      Rails.logger.warn("Saved #{ms_line.sel_id}")
    else
      Rails.logger.warn("Failed to save #{ms_line.sel_id}. #{ms_line.errors}")
    end
  end

  def line_note?(line_number, note_keys)
    return true if note_keys.map{ |key| key.split('.').first }.include?(line_number)
  end

  def notes_for_line(line_number, notes)
    notes.select{ |key, _val| key.split('.').first == line_number }
  end

  def create_line(line, index, witness, dictionary, foliation, notes)
    ms_line = ManuscriptLine.new
    ms_line.witness = witness
    ms_line.witness_line_number = index + 1
    ms_line.sel_id = "#{witness.manuscript.siglum}-#{witness.saints_legend.siglum}-#{ms_line.witness_line_number}"
    ms_line.ms_line_number = create_manuscript_line_number(ms_line.witness_line_number, foliation)
    ms_line.transcribed_line = line
    expanded_line = line

    if line_note?(ms_line.witness_line_number, notes.keys)
      expanded_line, note_text = annotated_line_and_notes(
        expanded_line, ms_line.witness_line_number, notes, ms_line.sel_id
      )
      ms_line.notes = note_text
    end

    dictionary.to_hash.each do |abbrev|
      expanded_line.gsub!(abbrev[0], abbrev[1])
    end
    ms_line.html_line = expanded_line

    if ms_line.save
      Rails.logger.warn("Saved #{ms_line.sel_id}")
    else
      Rails.logger.warn("Failed to save #{ms_line.sel_id}. #{ms_line.errors}")
    end
  end
end
