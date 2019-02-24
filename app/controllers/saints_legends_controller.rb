# frozen_string_literal: true

class SaintsLegendsController < ApplicationController

  def index
    @saints_legends = SaintsLegend.all
    render json: { saints_legends: @saints_legends.as_json(except: %i[created_at updated_at]) }
  end
end
