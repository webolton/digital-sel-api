# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Witness, type: :model do
  describe '.for_ms_and_siglum' do
    subject(:do_action) { Witness.for_ms_and_siglum(id_or_sig, sig) }
    let(:manuscript) { create(:manuscript) }
    let(:saints_legend) { create(:saints_legend) }
    let!(:witness) { create(:witness, manuscript_id: manuscript.id, saints_legend_id: saints_legend.id) }

    context 'when the query is for a witness that exists' do
      context 'when a siglum is passed in the first argument' do
        let(:id_or_sig) { manuscript.siglum }
        let(:sig) { saints_legend.siglum }
        it 'returns the witness' do
          expect(do_action).to eq(witness)
        end
      end
      context 'when an id is passed in the first argument' do
        let(:id_or_sig) { manuscript.id }
        let(:sig) { saints_legend.siglum }
        it 'returns the witness' do
          expect(do_action).to eq(witness)
        end
      end
      context 'when a bad id is passed in the first argument' do
        let(:id_or_sig) { 3000 }
        let(:sig) { saints_legend.siglum }
        it 'returns nil' do
          expect(do_action).to be_nil
        end
      end
      context 'when a bad siglum is passed in the first argument' do
        let(:id_or_sig) { 'catsarenice' }
        let(:sig) { saints_legend.siglum }
        it 'returns nil' do
          expect(do_action).to be_nil
        end
      end
    end
  end
end
