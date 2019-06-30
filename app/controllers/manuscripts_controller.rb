# frozen_string_literal: true

# For manuscript management
class ManuscriptsController < ApplicationController
  def index
    @manuscripts = Manuscript.all.includes(:witnesses)
                             .as_json(except: %(created_at updated_at),
                                      include: [witnesses: { except: %i[created_at updated_at],
                                                             methods: :sl_siglum }])
    render json: { manuscripts: @manuscripts }
  end
end
