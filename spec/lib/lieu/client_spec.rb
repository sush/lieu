require 'spec_helper'

describe Lieu::Client do
  describe 'module configuration' do
    before do
      Lieu.reset!

      Lieu.configure do |config|
        Lieu::Configuration::VALID_OPTIONS.each do |key|
          config.send("#{key}=", "Some #{key}")
        end
      end
    end

    after { Lieu.reset! }

    it "inherits the module configuration" do
      client = Lieu::Client.new

      Lieu::Configuration::VALID_OPTIONS.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq "Some #{key}"
      end
    end
  end

  context 'with class level configuration' do
    describe 'api_endpoint' do
      it 'sets api_endpoint' do
        client = Lieu::Client.new

        expect(client.api_endpoint).
          to eql 'https://maps.googleapis.com/maps/api/place/'
      end

      it 'overrides module configuration' do
        client = Lieu::Client.new(api_endpoint: 'http://fuubar.com')

        expect(client.api_endpoint).to eql 'http://fuubar.com'
      end
    end

    describe 'api_key' do
      it 'sets api_key'  do
        client = Lieu::Client.new

        expect(client.api_key).to be_nil
      end

      it 'overrides module configuration' do
        client = Lieu::Client.new(api_key: 'randomkey')

        expect(client.api_key).to eql 'randomkey'
      end
    end

    describe 'sensor' do
      it 'sets sensor'  do
        client = Lieu::Client.new

        expect(client.sensor).to be_false
      end

      it 'overrides module configuration' do
        client = Lieu::Client.new(sensor: true)

        expect(client.sensor).to be_true
      end
    end
  end
end
