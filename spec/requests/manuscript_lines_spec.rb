# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST /manuscript_lines', type: :request do
  subject(:do_action) { post '/manuscript_lines', params: params }
  let(:params) { {} }

  context 'when a user is not signed in' do
    it_behaves_like 'an unauthorized request'
  end

end
