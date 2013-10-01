require 'spec_helper'

describe Lieu do
  describe '.respond_to?' do
    context 'with an existing Lieu method' do
      it 'responds to method' do
        expect(Lieu.respond_to?(:new, true)).to be_true
      end
    end

    context 'with an existing Lieu::Client method' do
      it 'responds to method' do
        expect(Lieu.respond_to?(:get, true)).to be_true
      end

      it 'delegates to Lieu::Client' do
        Lieu::Client.stub_chain(:new, :get).and_return(true)

        expect(Lieu::Client).to receive(:new).ordered
        expect(Lieu::Client).to receive(:new).ordered

        Lieu.get('fuubar')
      end
    end
  end

  describe '.new' do
    it 'returns a Lieu::Client' do
      expect(Lieu.new).to be_a Lieu::Client
    end
  end
end
