# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe UsersController, type: :controller do

  describe '#index' do
    subject(:do_action) { get :index }
    let(:users) { create_list(:user, 4) }

    context 'when a user is not signed in' do
      it_behaves_like 'an unauthorized request'
    end

    context 'when an admin is signed in' do
      let!(:users) { create_list(:user, 4) }
      let(:admin) { create(:admin) }
      before { jwt_sign_in(admin) }

      it_behaves_like 'a successful request'

      it 'returns all the users' do
        do_action
        expect(parsed_body['users'].map{ |user| user['email'] }).to include(*User.all.map(&:email))
      end

      it 'returns a user in the right format' do
        do_action
        user_data = parsed_body['users'].first.to_hash
        actual_user = User.find(user_data['id'])
        expect(user_data).to eq({ id: actual_user.id, first_name: actual_user.first_name,
                                  last_name: actual_user.last_name, email: actual_user.email,
                                  admin: actual_user.admin }.with_indifferent_access)
      end
    end

    context 'when a non-admin user is logged in' do
      let(:user) { create(:user) }
      before { jwt_sign_in(user) }

      it_behaves_like 'a forbidden request'
    end
  end

  describe '#show' do
    subject(:do_action) { get :show, params: { id: user_id } }
    let(:user) { create(:user) }
    let(:user_id) { user.id }

    context 'when a user is not signed in' do
      it_behaves_like 'an unauthorized request'
    end

    context 'when an admin is signed in' do
      let(:admin) { create(:admin) }
      before { jwt_sign_in(admin) }

      it_behaves_like 'a successful request'

      it 'returns the correct JSON shape' do
        do_action
        expect(parsed_body).to eq({ user: { id: user.id, first_name: user.first_name, last_name: user.last_name,
                                            email: user.email, admin: user.admin } }.with_indifferent_access)
      end

      context 'when the user_id does not exist' do
        let(:user_id) { 777_777_777_777 }

        it_behaves_like 'a request for a missing resource', 'User'
      end

      context 'when the user_id is not an integer or cannot be coerced to a string' do
        let(:user_id) { 'four' }

        it_behaves_like 'a bad request'

        it 'returns the correct error message' do
          do_action
          expect(parsed_body).to eq({ errors: ['Invalid id format'] }.with_indifferent_access)
        end
      end

      context 'when the id cast as a number' do
        let(:user_id) { user.id.to_s }

        it_behaves_like 'a successful request'
      end
    end

    context 'when a non-admin is logged in' do
      let(:user) { create(:user) }
      before { jwt_sign_in(user) }

      context 'when a non-admin user tries to view another user' do
        let(:other_user) { create(:user) }
        let(:user_id) { other_user.id }

        it_behaves_like 'a forbidden request'
      end

      context 'when a non-admin tries to view herself' do
        let(:user_id) { user.id }

        it_behaves_like 'a successful request'

        it 'returns the correct JSON shape' do
          do_action
          expect(parsed_body).to eq({ user: { id: user.id, first_name: user.first_name, last_name: user.last_name,
                                              email: user.email, admin: user.admin } }.with_indifferent_access)
        end
      end
    end
  end

  describe '#create' do
    let(:first_name) { Faker::Name.first_name }
    let(:last_name) { Faker::Name.last_name }
    let(:email) { Faker::Internet.email }
    let(:password) { Faker::Crypto.sha1 }
    let(:password_confirmation) { password }
    let(:user_params) do
      { user:
             { first_name: first_name,
               last_name: last_name,
               email: email,
               password: password,
               password_confirmation: password_confirmation } }
    end

    subject(:do_action) do
      post :create, params: user_params
    end

    context 'when an admin is logged in' do
      let(:admin) { create(:admin) }
      before { jwt_sign_in(admin) }

      it_behaves_like 'a successfully created request'

      it 'successfully creates a new user' do
        expect { do_action }.to change { User.count }.by(1)
      end

      context 'when an invalid email and first_name are passed' do
        let(:email) { 'ke$ha' }
        let(:first_name) { '' }

        it_behaves_like 'an unprocessible entity'

        it 'returns the correct errors' do
          do_action
          expect(parsed_body).to eq({ errors: ['Invalid email', 'First name cannot be blank'] }.with_indifferent_access)
        end
      end
    end

    context 'when a non-admin user is logged in' do
      let(:user) { create(:user) }
      before { jwt_sign_in(user) }

      it_behaves_like 'a forbidden request'

      it 'does not create a new user' do
        expect{ do_action }.not_to(change { User.count })
      end
    end
  end

  describe '#update' do
    subject(:do_action) do
      post :update, params: { id: user_id, user: user_params }
    end

    let(:user) { create(:user) }
    let(:user_id) { user.id }

    context 'when an admin is logged in' do
      let(:user_params) { { first_name: 'Margery', last_name: 'Kempe' } }
      let(:admin) { create(:admin) }
      before { jwt_sign_in(admin) }

      it_behaves_like 'a successful request'

      it 'successfully updates the user\'s name' do
        do_action
        expect(user.reload.first_name).to eq('Margery')
      end
    end
  end
end
