# frozen_string_literal: true

def jwt_sign_in(user)
  headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
  auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
  auth_headers.each { |key, value| @request.headers[key] = value }
end
