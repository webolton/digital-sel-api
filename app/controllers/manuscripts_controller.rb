# frozen_string_literal: true

class ManuscriptsController < ApplicationController

  def index
    @manuscripts = Manuscript.all
    render json: { manuscripts: @manuscripts.as_json(methods: %i[date_range witness_count],
                                                     only: %i[id siglum shelfmark status]) }
  end
end
