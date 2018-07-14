# frozen_string_literal: true

require 'rails_helper'
require 'securerandom'

RSpec.describe Users::RegistrationsController do

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    User.destroy_all
  end

  describe '#register' do
    subject(:do_action) { post :create, params: params }
    let(:email) { 'user@example.com' }
    let(:first_name) { 'Geoffery' }
    let(:last_name) { 'Chaucer' }
    let(:params) { { user: {
                             email: email, password: 'password',
                             first_name: first_name, last_name: last_name
                  } } }

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
          expect(response.body).to eq({ errors: { email: ['Email has already been taken'] } }.to_json)
        end
      end

      context 'when the parameters are empty' do
        let(:params) { { user: {} } }

        it_behaves_like 'a bad request'

        it 'throws the correct error' do
          do_action
          expect(response.body).to eq({ errors: { email:      ['Email cannot be blank', 'Email invalid'],
                                                  password:   ['Password cannot be blank'],
                                                  first_name: ['First name cannot be blank'],
                                                  last_name:  ['Last name cannot be blank']
                                                } }.to_json)
        end
      end
    end
  end
end
