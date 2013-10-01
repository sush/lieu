module Lieu
  class Client
    # Methods for the Place Autocomplete API
    #
    # @see https://developers.google.com/places/documentation/autocomplete
    module Autocomplete
      # Search a place.
      # @param input [String] the search term
      # @param options [Hash] optional parameters
      # @return [Array<Hashie::Mash>] a list of predicted places
      # @see https://developers.google.com/places/documentation/autocomplete#place_autocomplete_requests
      # @example
      #   Lieu.autocomplete('Le Zenith Paris')
      def autocomplete(input, options={})
        options.merge!(input: input)

        get('autocomplete', options).predictions
      end
    end
  end
end
