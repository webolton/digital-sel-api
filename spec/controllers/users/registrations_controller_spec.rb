# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Users::RegistrationsController do

  before do
    request.env['devise.mapping'] = Devise.mappings[:user]
    User.destroy_all
  end

  describe '#register' do
    subject(:do_action) { post :create, params: params }
    let(:email) { 'user@example.com' }
    let(:params) { { user: { email: email, password: 'password' } } }

    context 'when user is unauthenticated' do
      it_behaves_like 'a successful request'

      it 'creates a new user' do
        expect { do_action }.to change { User.count }.by(1)
      end

      it 'returns the correct JSON shape' do
        do_action
        expect(response.body).to eq({ success: { email: 'user@example.com' } }.to_json)
      end

      context 'when the email is already taken' do
        let!(:user) { create(:user) }
        let(:email) { user.email }

        it_behaves_like 'a bad request'

        it 'throws the correct error' do
          do_action
          expect(response.body).to eq({ errors: { email: ['Email has already been taken.'] } }.to_json)
        end
      end

      context 'when the parameters are empty' do
        let(:params) { { user: {} } }

        it_behaves_like 'a bad request'

        it 'throws the correct error' do
          do_action
          expect(response.body).to eq({ errors: { email: ['can\'t be blank'],
                                                  password: ['can\'t be blank'] } }.to_json)
        end
      end
    end
  end
end
