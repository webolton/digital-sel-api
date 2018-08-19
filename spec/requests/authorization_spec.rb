# frozen_string_literal: true

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
      expect(JWT.decode(token, Settings.devise.devise_jwt_secret_key).first['sub']).to be_present
    end

    it 'returns the correct user shape' do
      do_action
      new_user = User.last
      expect(JSON.parse(response.body)).to eq(
        {
          id: new_user.id, email: new_user.email, first_name: new_user.first_name,
          last_name: new_user.last_name, admin: new_user.admin
        }.with_indifferent_access
      )
    end
  end

  context 'when login params are incorrect' do
    let(:params) { { user: { email: 'fake_email@catmail.com', password: 'fake_password' } } }

    it_behaves_like 'an unauthorized request'
  end
end

RSpec.describe 'DELETE /users/sign_out', type: :request do
  subject(:do_action) { delete '/users/sign_out' }

  it_behaves_like 'a sign_out request'
end
