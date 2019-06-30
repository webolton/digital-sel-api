# frozen_string_literal: true

class ManuscriptsController < ApplicationController
  def index
    @manuscripts = Manuscript.all.includes(:witnesses).as_json(except: %(created_at updated_at),
                                                               include: [witnesses: { except: %i[created_at updated_at] }])
    render json: { manuscripts: @manuscripts }
  end
end
