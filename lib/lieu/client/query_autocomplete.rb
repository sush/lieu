module Lieu
  class Client
    # Methods for the Query Autocomplete API
    #
    # @see https://developers.google.com/places/documentation/query
    module QueryAutocomplete
      # Perform a categorical search.
      # @param input [String] the search term
      # @param options [Hash] optional parameters
      # @return [Array<Hashie::Mash>] a list of predicted places
      # @see https://developers.google.com/places/documentation/query#query_autocomplete_requests
      # @example
      #   Lieu.query_autocomplete('Pizza Paris')
      def query_autocomplete(input, options={})
        options.merge!(input: input)

        get('queryautocomplete', options).predictions
      end
    end
  end
end
