# frozen_string_literal: true

class SaintsLegendsController < ApplicationController
  def index
    @saints_legends = SaintsLegend.all.includes(:witnesses).as_json(
      except: %i[created_at updated_at],
      include: [witnesses: { except: %i[created_at updated_at], methods: :ms_siglum }]
    )
    render json: { saints_legends: @saints_legends }
  end
end
