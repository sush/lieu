require 'spec_helper'

describe Lieu::Client::Details do
  describe '.details', :vcr do
    it 'returns a place details' do
      place = client.details(place_reference)

      expect(place.name).to eql 'Google Sydney'
    end
  end
end
