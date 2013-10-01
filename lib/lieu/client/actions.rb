module Lieu
  class Client
    # Methods for the Place Actions API
    #
    # @see https://developers.google.com/places/documentation/actions
    module Actions
      # Add a place.
      # @param options [Hash] a customizable set of options
      # @option options [Hash] :location the location of place
      #   * :lat (String) the place latitude
      #   * :lng (String) the place longitude
      # @option options [String] :accuracy the accuracy of location
      # @option options [String] :name the place name
      # @option options [Array] :types the place types
      # @option options [String] :language the place name language
      # @return [Hashie::Mash] the created place details
      # @see https://developers.google.com/places/documentation/actions#PlaceReportRequests
      # @example
      #   Lieu.add(
      #     reference: 'place_reference',
      #     location: {
      #       lat: '0.00',
      #       lng: '0.00'
      #     },
      #     name: 'Fuubar',
      #     types: [
      #       'shoe_store'
      #     ],
      #     language: 'fr'
      #   )
      def add(options={})
        post('add', options)
      end

      # Delete a place.
      # @param options [Hash] a customizable set of options
      # @option options [String] :reference the place reference
      # @return [Boolean] true if removal was successful, false otherwise
      # @see https://developers.google.com/places/documentation/actions#PlaceReportRequests
      # @example
      #   Lieu.delete(reference: 'place_reference')
      def delete(options={})
        boolean_from_response(:post, 'delete', options)
      end

      # Bump a place or an event.
      # @param options [Hash] a customizable set of options
      # @option options [String] :reference the place reference
      # @option options [String] :event_id the event id
      # @return [Boolean] true if bump was successful, false otherwise
      # @see https://developers.google.com/places/documentation/actions#bump
      # @example Bump a place
      #   Lieu.bump(reference: 'place_reference')
      # @example Bump an event
      #   Lieu.bump(reference: 'place_reference', event_id: 'event_id')
      def bump(options={})
        boolean_from_response(:post, 'bump', options)
      end

      # Add an event to a place.
      # @param options [Hash] a customizable set of options
      # @option options [String] :reference the place reference
      # @option options [String] :duration the event duration
      # @option options [String] :language the event language
      # @option options [String] :summary the event summary
      # @option options [String] :url the event url
      # @return [Hashie::Mash] the created event details
      # @see https://developers.google.com/places/documentation/actions#event_intro
      # @example
      #   Lieu.add_event(
      #     reference: 'place_reference',
      #     duration: '15',
      #     language: 'fr',
      #     summary: 'Nice event',
      #     url: 'http://fuubar.com/events/fuubar/'
      #   )
      def add_event(options={})
        post('event/add', options)
      end

      # Delete an event from a place.
      # @param options [Hash] a customizable set of options
      # @option options [String] :reference the place reference
      # @option options [String] :event_id the event id
      # @return [Boolean] true if deletion was successful, false otherwise
      # @see https://developers.google.com/places/documentation/actions#event_intro
      # @example
      #   Lieu.delete_event(reference: 'place_reference', event_id: 'event_id')
      def delete_event(options={})
        boolean_from_response(:post, 'event/delete', options)
      end

      # Get an event details.
      # @param reference [String] the event place reference
      # @param event_id [String] the event id
      # @param options [Hash] optionnal parameters
      # @return [Hashie::Mash] the event details
      def event_details(reference, event_id, options={})
        options.merge!(reference: reference, event_id: event_id)

        get('event/details', options).result
      end
    end
  end
end
