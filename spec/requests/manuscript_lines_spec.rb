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

    context 'when all required parameters are sent' do
      let(:params) do
        { manuscript_line: {
          ms_siglum: 'E',
          saints_legend_siglum: 'bo',
          foliation: {
            '1..19' => '161r',
            '20..62' => '161v',
            '63..69' => '162r'
          },
          dictionary: {
            Botulf: '<span class=\'personal-name saint botulf-of-thorney\'>Botulf</span>',
            botulf: '<span class=\'personal-name saint botulf-of-thorney\'>Botulf</span>'
          }
        } }.to_json
      end

      context 'when a witness cannot be found' do
        it_behaves_like 'a not found request'
        it 'returns the correct error' do
          do_action
          expect(response_body['errors'].first).to eq('Witness not found for MS: E and Legend: bo')
        end
      end

      context 'when a witness can be found' do
        let!(:manuscript) { create(:manuscript, siglum: 'E') }
        let!(:saints_legend) { create(:saints_legend, siglum: 'bo') }
        let!(:witness) { create(:witness, saints_legend: saints_legend, manuscript: manuscript) }

        it_behaves_like 'a successfully created request'
      end
    end
  end

end
