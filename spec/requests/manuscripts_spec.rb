# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /manuscripts', type: :request do
  subject(:do_action) { get '/manuscripts' }
  let(:manuscripts) { create_list(:manuscript, 5) }
  let(:saints_legend) { create(:saints_legend) }
  before do
    manuscripts.each do |manuscript|
      create_list(:witness, 4, manuscript: manuscript, saints_legend: saints_legend)
    end
  end

  context 'when there are more than one manuscript' do

    it_behaves_like 'a successful request'

    it 'returns the correct number of manuscripts' do
      do_action
      expect(response_body['manuscripts'].length).to eq(5)
    end

    it 'returns the correct JSON body shape' do
      do_action
      expect(response_body['manuscripts'].map(&:keys).first).to eq(
        %w[id shelfmark siglum status date_range witness_count]
      )
    end

    it 'returns the correct number of witnesses per manuscript' do
      do_action
      expect(response_body['manuscripts'].map { |ms| ms['witness_count'] }.uniq).to eq([4])
    end

    it 'returns null for date_range for each manuscript' do
      do_action
      expect(response_body['manuscripts'].map { |ms| ms['date_range'] }.uniq).to eq([nil])
    end
  end
end
