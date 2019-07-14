# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /witnesses', type: :request do
  subject(:do_action) { get '/witnesses' }
  let(:saints_legend) { create(:saints_legend) }
  let!(:witnesses) { create_list(:witness, 5, saints_legend: saints_legend) }

  context 'when there more than one saints\' legends' do
    it_behaves_like 'a successful request'

    it 'returns the correct number of witnesses' do
      do_action
      expect(response_body['witnesses'].length).to eq(5)
    end

    it 'returns the correct JSON body shape' do
      do_action
      expect(response_body['witnesses'].map(&:keys).first).to eq(
        %w[id manuscript_id saints_legend_id position folios description notes incipit explicit
           transcribed ms_siglum shelfmark sl_siglum title]
      )
    end
  end
end
