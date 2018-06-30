require 'rails_helper'

RSpec.describe Users::RegistrationsController do

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    User.destroy_all
  end

  subject(:do_action) { post :create, params: params }
  let(:params) { { user: { email: 'user@example.com', password: 'password' } } }

  context 'when user is unauthenticated' do
    it_behaves_like 'a successful request'

    it 'creates a new user' do
      expect{ do_action }.to change{ User.count }.by(1)
    end

    it 'returns the correct JSON shape' do
      do_action
      expect(response.body).to eq({ success: { email: 'user@example.com' } }.to_json)
    end
  end
end
