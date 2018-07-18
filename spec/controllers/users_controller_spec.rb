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

      it 'returns the correct users shape' do
        do_action
        expect(JSON.parse(response.body)['users'].map{ |user| user['email'] }).to include(*User.all.map(&:email))
      end
    end
  end
end
