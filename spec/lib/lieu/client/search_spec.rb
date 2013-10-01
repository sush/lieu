require 'spec_helper'

describe Lieu::Client::Search do
  let(:options) do
    {
      location: {
        lat: '48.85341',
        lng: '2.3488'
      },
      radius: '1500'
    }
  end

  describe '.nearby_search', :vcr do
    it 'returns an array of places' do
      places = client.nearby_search(options)

      expect(places).to be_a Array
    end
  end

  describe '.textsearch', :vcr do
    it 'returns an array of places' do
      places = client.text_search('Google Sydney')

      expect(places).to be_a Array
    end
  end

  describe '.radarsearch', :vcr do
    before { options.merge!(types: ['bank', 'atm']) }

    it 'returns an array of places' do
      places = client.radar_search(options)

      expect(places).to be_a Array
    end
  end
end
