# frozen_string_literal: true

module Helpers
  # Controller helpers

  def parsed_body
    JSON.parse(response.body)
  end

  def test_auth_headers(user)
    headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
    Devise::JWT::TestHelpers.auth_headers(headers, user)
  end

  def jwt_sign_in(user)
    auth_headers = test_auth_headers(user)
    auth_headers.each { |key, value| @request.headers[key] = value }
  end

  def response_body
    JSON.parse(response.body)
  end
end
