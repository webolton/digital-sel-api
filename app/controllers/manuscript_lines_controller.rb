# frozen_string_literal: true

class ManuscriptLinesController < ApplicationController
  def create
    ms_siglum = manuscript_line_params['manuscript_line']['ms_siglum']
    legend_siglum = manuscript_line_params['manuscript_line']['saints_legend_siglum']
    dictionary = manuscript_line_params['manuscript_line']['dictionary']
    witness = Witness.for_ms_and_siglum(ms_siglum, legend_siglum)
    foliation = manuscript_line_params['manuscript_line']['foliation']

    transcription_path = Dir.glob(
      Rails.root.join('docs', 'transcriptions', ms_siglum.downcase, legend_siglum, '*.seltxt')
    ).first
    lines = File.readlines(transcription_path)

    notes_path = Dir.glob(
      Rails.root.join('docs', 'transcriptions', ms_siglum.downcase, legend_siglum, 'notes.md')
    ).first
    notes = File.readlines(notes_path)

  end

  def manuscript_line_params
    params.permit(manuscript_line: {})
  end
end
