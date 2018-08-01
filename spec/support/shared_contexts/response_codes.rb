# frozen_string_literal: true

shared_context 'a successful request' do
  it 'returns an OK (200) status code' do
    do_action
    expect(response.status).to eq(200)
  end
end

shared_context 'a successfully created request' do
  it 'returns an CREATED (201) status code' do
    do_action
    expect(response.status).to eq(201)
  end
end

shared_context 'a sign_out request' do
  it 'returns a NO CONTENT (204) status code' do
    do_action
    expect(response.status).to eq(204)
  end
end

shared_context 'a bad request' do
  it 'returns a BAD REQUEST (400) status code' do
    do_action
    expect(response.status).to eq(400)
  end
end

shared_context 'a request for a missing resource' do |resource_name|
  it 'returns a NOT FOUND (404) status code' do
    do_action
    expect(response.status).to eq(404)
    expect(JSON.parse(response.body)['errors']).to eq(["#{resource_name} not found"])
  end
end

shared_context 'an unauthorized request' do
  it 'returns a UNAUTHORISED (401) status code and the correct response body' do
    do_action
    expect(response.status).to eq(401)
    expect(parsed_body).to eq({ errors: ['Unauthorized'] }.with_indifferent_access)
  end
end

shared_context 'a forbidden request' do
  it 'returns a FORBIDDEN (403) status code and the correct response body' do
    do_action
    expect(response.status).to eq(403)
    expect(parsed_body).to eq({ errors: ['Unpermitted action'] }.with_indifferent_access)
  end
end
