# frozen_string_literal: true

class CustomFailureApp < Devise::FailureApp
  def respond
    json_error_response
  end

  def json_error_response
    self.status = 401
    self.content_type = 'application/json'
    self.response_body = { errors: ['Unauthorized'] }.to_json
  end
end
