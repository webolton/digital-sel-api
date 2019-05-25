# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET /saints_legends', type: :request do
  subject(:do_action) { get '/saints_legends' }
  let(:saints_legends) { create_list(:saints_legend, 5) }

  context 'when there more than one saints\' legends' do
    it_behaves_like 'a successful request'
  end
end
