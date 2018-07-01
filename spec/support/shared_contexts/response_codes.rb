# frozen_string_literal: true

shared_context 'a successful request' do
  it 'returns an OK (200) status code' do
    do_action
    expect(response.status).to eq(200)
  end
end

shared_context 'a bad request' do
  it 'returns a BAD REQUEST (400) status code' do
    do_action
    expect(response.status).to eq(400)
  end
end
