require 'faraday'
require 'lieu/error'

module Lieu
  # Faraday response middleware
  module Response
    # Raises a Lieu exception based on status response or HTTP status codes returned by the API
    class RaiseError < Faraday::Response::Middleware
      private

      def on_complete(response)
        if error = Lieu::Error.from_response(response)
          raise error
        end
      end
    end
  end
end
