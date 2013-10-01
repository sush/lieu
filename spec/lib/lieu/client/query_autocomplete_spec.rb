require 'spec_helper'

describe Lieu::Client::QueryAutocomplete do
  describe '.query_autocomplete', :vcr do
    it 'returns an array of places' do
      places = client.query_autocomplete('Google Sydney')

      expect(places).to be_a Array
    end
  end
end
