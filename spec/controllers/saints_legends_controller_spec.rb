require 'rails_helper'

RSpec.describe SaintsLegendsController, type: :controller do
  describe '#index' do
    subject(:do_action) { get :index }

    context 'when there are more than one saints\' legend' do
      before do
        create_list(:saints_legend, 5)
      end

      it_behaves_like 'a successful request'

      it 'returns the correct number of objects' do
        do_action
        expect(response_body['saints_legends'].length).to eq(5)
      end
      it 'returns objects with the correct JSON shape' do
        do_action
        response_body['saints_legends'].map do |ms|
          expect(ms.keys).to match_array(
            %w[id siglum title incipit calendar_day date dimev_number imev_number nimev_number notes
               position summary versification]
          )
        end
      end
    end
  end
end
