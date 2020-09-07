# frozen_string_literal: true

class ManuscriptLinesController < ApplicationController
  include ManuscriptLinesControllerConcern
  before_action :authenticate_user!
  authorize_resource

  def create # TODO: Simplify
    ms_siglum     = manuscript_line_params['ms_siglum']
    legend_siglum = manuscript_line_params['saints_legend_siglum']
    dictionary    = manuscript_line_params['dictionary']
    foliation     = manuscript_line_params['foliation']

    if [ms_siglum, legend_siglum, dictionary, foliation].any?(&:nil?)
      render_errors(['All Manuscript Lines params required'], 400)
      return
    end

    witness = Witness.for_ms_and_siglum(ms_siglum, legend_siglum)

    unless witness
      render_errors(["Witness not found for MS: #{ms_siglum} and Legend: #{legend_siglum}"], 404)
      return
    end

    lines = read_file(ms_siglum, legend_siglum, false)

    notes = read_file(ms_siglum, legend_siglum, true)

    begin
      notes.each do |key, value|
        if key.split('.').last == '0'
          create_marginal_note(key, value, witness, foliation)
          notes.delete(key)
        end
      end

      lines.each_with_index do |line, index|
        create_line(line, index, witness, dictionary, foliation, notes)
      end
      render json: { success: 'Manuscript Lines successfully imported' }, status: 201
    rescue StandardError => e
      render_errors(["Something went wrong: #{e}"], 500)
    end
  end

  def manuscript_line_params
    params.require(:manuscript_line).permit(:ms_siglum, :saints_legend_siglum, dictionary: {}, foliation: {})
  end
end
