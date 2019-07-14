# frozen_string_literal: true

class WitnessesController < ApplicationController
  def index
    @witnesses = Witness.all.as_json(
      except: %i[created_at updated_at], methods: %i[ms_siglum shelfmark sl_siglum title]
    )
    render json: { witnesses: @witnesses }
  end
end
