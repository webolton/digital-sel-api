require 'rails_helper'

# The authorization header is not available in controller specs

RSpec.describe 'POST /users/sign_in', type: :request do
  subject(:do_action) { post '/users/sign_in', params: params }
  let(:user) { create(:user) }
  let(:params) { { user: { email: user.email, password: user.password } } }

  context 'when params are correct' do

    it_behaves_like 'a successful request'

    it 'returns JTW token in authorization header' do
      do_action
      expect(response.headers['Authorization']).to be_present
    end

    it 'returns valid JWT token' do
      do_action
      token = response.headers['Authorization'].split('Bearer ').last
      expect(JWT.decode(token, ENV['DEVISE_JWT_SECRET_KEY']).first['sub']).to be_present
    end
  end

  context 'when login params are incorrect' do
  let(:params) { { user: { email: 'fake_email@catmail.com', password: 'fake_password' } } }

    it_behaves_like 'an unauthorized request'
  end
end

# RSpec.describe 'DELETE /logout', type: :request do
#   let(:url) { '/logout' }

#   it 'returns 204, no content' do
#     delete url
#     expect(response).to have_http_status(204)
#   end
# end
