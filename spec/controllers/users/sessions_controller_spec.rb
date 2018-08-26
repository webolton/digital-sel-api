# frozen_string_literal: true

require 'rails_helper'
require 'securerandom'
require 'devise/jwt/test_helpers'

RSpec.describe Users::SessionsController do

  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    User.destroy_all
  end

  describe '#destroy' do
    subject(:do_action) { delete :destroy }

    context 'when a user is logged in' do
      let(:user) { create(:user) }
      before { jwt_sign_in(user) }
      it 'sets the current user to nil' do
        expect { do_action }.to change { controller.current_user }.to(nil)
      end
    end
  end
end
