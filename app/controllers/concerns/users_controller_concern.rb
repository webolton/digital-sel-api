# frozen_string_literal: true

module UsersControllerConcern
  extend ActiveSupport::Concern

  private

  def format_user(user)
    { id: user.id, first_name: user.first_name, last_name: user.last_name, email: user.email, admin: user.admin }
  end
end
