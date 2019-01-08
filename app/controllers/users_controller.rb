# frozen_string_literal: true

class UsersController < ApplicationController
  include UsersControllerConcern
  before_action :authenticate_user!
  before_action only: [:show] { validate_id(params[:id]) }
  load_and_authorize_resource

  def index
    users = User.all
    render json: { users: users.map { |user| format_user(user) } }, status: 200
  end

  def show
    validate_id(params[:id])
    render json: { user: format_user(@user) }, status: 200
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { success: 'User created', user_id: user.id }, status: 201
    else
      render_errors(user)
    end
  end

  def update
    if @user.update(user_params)
      render json: { user: format_user(@user) }, status: 200
    else
      render_errors(@user)
    end
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :password, :password_confirmation)
  end
end
