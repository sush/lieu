require 'spec_helper'

describe Lieu::Client::Autocomplete do
  describe '.autocomplete', :vcr do
    it 'returns an array of places' do
      places = client.autocomplete('Google Sydney')

      expect(places).to be_a Array
    end
  end
end
