require 'spec_helper'

describe Lieu::Request do
  it_behaves_like 'an error', 'INVALID_REQUEST'
  it_behaves_like 'an error', 'REQUEST_DENIED'
  it_behaves_like 'an error', 'NOT_FOUND'
  it_behaves_like 'an error', 'UNKNOWN_ERROR'
  it_behaves_like 'an error', 'ZERO_RESULTS'
  it_behaves_like 'an error', 'OVER_QUERY_LIMIT'

  it_behaves_like 'a http error', 400, Lieu::InvalidRequest
  it_behaves_like 'a http error', 403, Lieu::OverQueryLimit

  context 'given a GET request' do
    context 'with options', :vcr do
      before { client.get('fuubar', language: 'fr') }

      it 'sets options as url parameters' do
        a_request(:get, google_places_url('fuubar')).
          with(query: { 'language' => 'fr' }).should have_been_made
      end
    end
  end

  context 'given a POST request' do
    context 'with options', :vcr do
      before { client.post('fuubar', test: 'toto') }

      it 'sets options as body parameters' do
        a_request(:post, google_places_url('fuubar')).
          with(body: { test: 'toto' }.to_json).should have_been_made
      end
    end
  end
end
