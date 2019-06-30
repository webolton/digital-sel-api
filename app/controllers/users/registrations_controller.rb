# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  def create
    build_resource(sign_up_params)

    if resource.save
      render json: { success: format_user(resource) }, status: :ok
    else
      render json: { errors: resource.errors }, status: :bad_request
    end
  end

  private

  def format_user(user)
    { email: user.email }
  end
end
