require 'spec_helper'

describe Lieu::Client::Actions do
  describe '.add' do
    let(:add_place_body) do
      {
        location: {
          lat: '-33.8669710',
          lng: '151.1958750'
        },
        accuracy: 50,
        name: 'Google Shoes!',
        types: [
          'shoe_store'
        ],
        language: 'en-AU'
      }
    end

    it 'adds a place' do
      VCR.turn_off!

      stub_post('add').with(add_place_body).to_return(
        body: { reference: '123', id: '456', status: 'OK' }.to_json,
        headers: json_content_type
      )

      new_place = client.add(add_place_body)

      expect(new_place.reference).to eql('123')
      expect(new_place.id).to eql('456')

      VCR.turn_on!
    end
  end

  describe '.delete' do
    let(:delete_place_body) do
      {
        reference: place_reference
      }
    end

    it 'deletes a place' do
      VCR.turn_off!

      stub_post('delete').with(delete_place_body).to_return(
        body: { status: 'OK' }.to_json,
        headers: json_content_type
      )

      delete_request = client.delete(reference: place_reference)

      expect(delete_request).to eql(true)

      VCR.turn_on!
    end
  end

  describe '.bump' do
    before { VCR.turn_off! }

    after { VCR.turn_on! }

    let(:bump_place_body) do
      {
        reference: place_reference
      }
    end

    context 'bumping a place' do
      it 'bumps a place' do
        stub_post('bump').with(bump_place_body).to_return(
          body: { status: 'OK' }.to_json,
          headers: json_content_type
        )

        bump_place_request = client.bump(reference: place_reference)

        expect(bump_place_request).to eql(true)
      end
    end

    context 'bumping an event' do
      let(:bump_event_body) do
        bump_place_body.merge({ event_id: '123' })
      end

      it 'bumps an event' do
        stub_post('bump').with(bump_event_body).to_return(
          body: { status: 'OK' }.to_json,
          headers: json_content_type
        )

        bump_event_request = client.bump(
          reference: place_reference,
          event_id: '123'
        )

        expect(bump_event_request).to eql(true)
      end
    end
  end

  describe '.add_event' do
    let(:add_event_body) do
      {
        duration: 172800,
        language: 'EN-CA',
        reference: 'CnRkAAAAGnBVNFDeQoOQHzgdOpOqJNV7K9-etc',
        summary: 'Rock n Roll Dreams: The band fully electric in my kitchen '\
        'and drinking all my beer.',
        url: 'http://www.example.com/event_details/10476.html'
      }
    end

    it 'adds an event' do
      VCR.turn_off!

      stub_post('event/add').with(add_event_body).to_return(
        body: { event_id: '123', status: 'OK' }.to_json,
        headers: json_content_type
      )

      new_event = client.add_event(add_event_body)

      expect(new_event.event_id).to eql('123')

      VCR.turn_on!
    end
  end

  describe '.delete_event' do
    let(:delete_event_body) do
      {
        reference: place_reference,
        event_id: '123'
      }
    end

    it 'deletes an event' do
      VCR.turn_off!

      stub_post('event/delete').with(delete_event_body).to_return(
        body: { status: 'OK' }.to_json,
        headers: json_content_type
      )

      delete_event_request = client.delete_event(
        reference: place_reference,
        event_id: '123'
      )

      expect(delete_event_request).to eql(true)

      VCR.turn_on!
    end

  end

  describe '.event_details', :vcr do
    it 'returns an event details' do
      place = nil

      VCR.use_cassette('Lieu_Client_Details/'\
                       '_details/returns_a_place_details') do
        place = client.details(place_reference)
      end

      event = client.event_details(
        place.reference,
        place.events.first.event_id
      )

      expect(event.event_id).not_to be_empty
    end
  end
end
