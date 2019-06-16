# frozen_string_literal: true

require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe 'POST /manuscript_lines', type: :request do
  subject(:do_action) { post '/manuscript_lines', params: params, headers: headers }
  let(:params) { {} }
  let(:headers) { nil }

  context 'when a user is not signed in' do
    it_behaves_like 'an unauthorized request'
  end

  context 'when a user is logged in' do
    let(:current_user) { create(:user) }
    let(:headers) { test_auth_headers(current_user) }

    it_behaves_like 'a forbidden request'
  end

  context 'when an admin is logged in' do
    let(:current_user) { create(:admin) }
    let(:headers) { test_auth_headers(current_user) }

    context 'when there are no parameters' do
      it_behaves_like 'a bad request'
    end

    context 'when parameters are missing' do
      let(:params) { { manuscript_line: { ms_siglum: 'E' } }.to_json }
      it_behaves_like 'a bad request'
    end
  end

end
