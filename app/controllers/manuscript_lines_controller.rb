# frozen_string_literal: true

class ManuscriptLinesController < ApplicationController
  include ManuscriptLinesControllerConcern
  before_action :authenticate_user!
  authorize_resource

  def create
    ms_siglum     = manuscript_line_params['ms_siglum']
    legend_siglum = manuscript_line_params['saints_legend_siglum']
    dictionary    = manuscript_line_params['dictionary']
    foliation     = manuscript_line_params['foliation']

    if [ms_siglum, legend_siglum, dictionary, foliation].any?(&:nil?)
      render_errors(['All Manuscript Lines params required'], 400)
      return
    end

    witness = Witness.for_ms_and_siglum(ms_siglum, legend_siglum)

    transcription_path = Dir.glob(
      Rails.root.join('docs', 'transcriptions', ms_siglum.downcase, legend_siglum, '*.seltxt')
    ).first
    lines = File.readlines(transcription_path)

    notes_path = Dir.glob(
      Rails.root.join('docs', 'transcriptions', ms_siglum.downcase, legend_siglum, 'notes.json')
    ).first

    notes = File.read(notes_path)
    notes = JSON.parse(notes).with_indifferent_access

    notes.each do |key, value|
      if key.split('.').last == '0'
        create_marginal_note(key, value, witness, foliation)
        notes.delete(key)
      end
    end

    lines.each_with_index do |line, index|
      create_line(line, index, witness, dictionary, foliation, notes)
    end
  end

  def manuscript_line_params
    params.require(:manuscript_line).permit(:ms_siglum, :saints_legend_siglum, dictionary: {}, foliation: {})
  end
end
