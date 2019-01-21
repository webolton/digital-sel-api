# frozen_string_literal: true

class StatusController < ApplicationController
  def index
    render json: { message: 'Nou blouweth the niwe frut . that late bygan to springe' }, status: 200
  end
end