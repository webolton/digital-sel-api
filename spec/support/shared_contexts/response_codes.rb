# frozen_string_literal: true

shared_context 'a successful request' do
  it 'returns an OK (200) status code' do
    do_action
    expect(response.status).to eq(200)
  end
end
