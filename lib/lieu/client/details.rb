module Lieu
  class Client
    # Methods for the Place Details API
    #
    # @see https://developers.google.com/places/documentation/details
    module Details
      # Get a place details.
      # @param reference [String] the place reference
      # @param options [Hash] optional parameters
      # @return [Hashie::Mash] the place details
      # @see https://developers.google.com/places/documentation/details#PlaceDetailsRequests
      # @example
      #   Lieu.details('place_reference')
      def details(reference, options={})
        options.merge!(reference: reference)

        get('details', options).result
      end
    end
  end
end
