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
                                  last_name: actual_user.last_name, email: actual_user.email }
                                .with_indifferent_access)
      end
    end

    context 'when a non-admin user is logged in' do
      let(:user) { create(:user) }
      before { jwt_sign_in(user) }

      it_behaves_like 'a forbidden request'
    end
  end
end
