module Lieu
  class Client
    # Methods for the Place Search API
    #
    # @see https://developers.google.com/places/documentation/search
    module Search
      # Search places within an area.
      # @param options [Hash] a customizable set of options
      # @option options [Hash] :location the location to find around
      #   * :lat (String) the latitude to find around
      #   * :lng (String) the longitude to find around
      # @option options [String] :radius the distance (in meters) to search in
      # @return [Array<Hashie::Mash>] a list of places details
      # @see https://developers.google.com/places/documentation/search#PlaceSearchRequests
      # @example
      #   Lieu.nearby_search(location: {
      #       lat: '0.00',
      #       lng: '0.00'
      #     },
      #     radius: '500'
      #   )
      def nearby_search(options={})
        options[:location] = format_location(options[:location])

        get('nearbysearch', options).results
      end

      # Text search places.
      # @param query [String] the text search term
      # @param options [Hash] optional parameters
      # @return [Array<Hashie::Mash>] a list of places details
      # @see https://developers.google.com/places/documentation/search#TextSearchRequests
      # @example
      #   Lieu.text_search('Tour Eiffel')
      def text_search(query, options={})
        options.merge!(query: query)

        get('textsearch', options).results
      end

      # Radar search places within an area.
      # @param options [Hash] a customizable set of options
      # @option options [Hash] :location the location to find around
      #   * :lat (String) the latitude to find around
      #   * :lng (String) the longitude to find around
      # @option options [String] :radius the distance (in meters) to search in
      # @option options [String] :keyword a term to be matched against all content for this place
      # @option options [String] :name a term to be matched against the names of places
      # @option options [Array<String>] :types types to restrict the results to
      # @return [Array<Hashie::Mash>] a list of places minimal details
      # @see https://developers.google.com/places/documentation/search#RadarSearchRequests
      # @example
      #   Lieu.radar_search(location: {
      #       lat: '0.00',
      #       lng: '0.00'
      #     },
      #     radius: '500',
      #     keyword: 'Pizza',
      #     name: 'Express'
      #   )
      def radar_search(options={})
        options[:location] = format_location(options[:location])
        options[:types] = format_types(options[:types]) if options[:types]

        get('radarsearch', options).results
      end

      private

      def format_location(location)
        "#{location[:lat]},#{location[:lng]}"
      end

      def format_types(types)
        types.join('|')
      end
    end
  end
end
