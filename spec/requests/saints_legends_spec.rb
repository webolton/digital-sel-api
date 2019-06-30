# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /saints_legends', type: :request do
  subject(:do_action) { get '/saints_legends' }
  let(:saints_legends) { create_list(:saints_legend, 5) }
  before do
    saints_legends.each do |legend|
      create_list(:witness, 4, saints_legend: legend)
    end
  end

  context 'when there more than one saints\' legends' do
    it_behaves_like 'a successful request'

    it 'returns the correct number of legends' do
      do_action
      expect(response_body['saints_legends'].length).to eq(5)
    end

    it 'returns the correct JSON body shape' do
      do_action
      expect(response_body['saints_legends'].map(&:keys).first).to eq(
        %w[id siglum title date summary position incipit imev_number nimev_number dimev_number notes
           versification calendar_day witnesses]
      )
    end
  end
end
