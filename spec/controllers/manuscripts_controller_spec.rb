# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ManuscriptsController, type: :controller do
  describe '#index' do
    subject(:do_action) { get :index }

    context 'when there are more than one manuscript' do
      before do
        create_list(:manuscript, 5)
      end

      it 'returns the correct number of objects' do
        do_action
        expect(response_body['manuscripts'].length).to eq(5)
      end
      it 'returns objects with the correct JSON shape' do
        do_action
        response_body['manuscripts'].map do |ms|
          expect(ms.keys).to match_array(
            %w[id shelfmark siglum country city repository date description dialect scribal_description
               provenance sc_number notes status owned price major_ms catalog_url digital_edition_url witnesses]
          )
        end
      end
    end
  end
end
