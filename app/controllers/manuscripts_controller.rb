# frozen_string_literal: true

class ManuscriptsController < ApplicationController

  def index
    @manuscripts = Manuscript.all
    render json: { manuscripts: @manuscripts.as_json(except: %i[created_at updated_at]) }
  end
end
