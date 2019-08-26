# frozen_string_literal: true

class WitnessesController < ApplicationController
  def index
    @witnesses = Witness.all.as_json(
      except: %i[created_at updated_at]
    )
    @saints_legends = SaintsLegend.all.includes(:witnesses).as_json(
      except: %i[created_at updated_at],
      include: [witnesses: { except: %i[created_at updated_at], methods: %i[ms_siglum shelfmark] }]
    )
    @manuscripts = Manuscript.all.includes(:witnesses).as_json(
      except: %(created_at updated_at),
      include: [witnesses: { except: %i[created_at updated_at], methods: %i[sl_siglum title]}])

    render json: { witnesses: @witnesses, manuscripts: @manuscripts, saints_legends: @saints_legends }, status: 200
  end
end
