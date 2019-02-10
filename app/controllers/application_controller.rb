# frozen_string_literal: true

class ApplicationController < ActionController::API
  respond_to :json
  rescue_from ActiveRecord::RecordNotFound, with: :resource_not_found
  rescue_from CanCan::AccessDenied, with: :not_permitted_response
  before_action :configure_permitted_parameters, if: :devise_controller?

  def validate_id(id)
    return if id.is_a?(Integer) || /\A[-+]?\d+\z/ === id

    render json: { errors: ['Invalid id format'] }, status: 400
  end

  def render_errors(object)
    render json: { errors: object.errors.values.flatten }, status: 400
  end

  def not_permitted_response
    render json: { errors: ['Unpermitted action'] }, status: 403
  end

  def resource_not_found(error)
    error_source = error.is_a?(String) ? error : error.model
    render json: { errors: ["#{error_source} not found"] }, status: 404
  end

  def internal_server_error(error_msg = '')
    render json: { errors: ['Unexpected server error', error_msg].reject(&:empty?) }, status: 500
    Rails.logger(error_msg)
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end
end
