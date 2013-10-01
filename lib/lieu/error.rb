require 'multi_json'

module Lieu
  # Custom error class
  class Error < StandardError
    # Returns the Error based on status and response message.
    #
    # @param [Hash] response HTTP response
    # @return [Lieu::Error]
    def self.from_response(response)
      content_type = response[:response_headers]['content-type']

      status =
        if content_type =~ /json/
          ::MultiJson.load(response[:body])['status']
        else
          response[:status]
        end

      case status
      when 'INVALID_REQUEST'
        raise Lieu::InvalidRequest, status
      when 'REQUEST_DENIED'
        raise Lieu::RequestDenied, status
      when 'NOT_FOUND'
        raise Lieu::NotFound, status
      when 'UNKNOWN_ERROR'
        raise Lieu::UnknownError, status
      when 'ZERO_RESULTS'
        raise Lieu::ZeroResults, status
      when 'OVER_QUERY_LIMIT'
        raise Lieu::OverQueryLimit, status
      when 400
        raise Lieu::InvalidRequest, status
      when 403
        raise Lieu::OverQueryLimit, status
      end
    end
  end

  # Raised when API returns INVALID_REQUEST or 400 HTTP code
  class InvalidRequest < Error; end

  # Raised when API returns REQUEST_DENIED
  class RequestDenied < Error; end

  # Raised when API returns NOT_FOUND
  class NotFound < Error; end

  # Raised when API returns UNKNOWN_ERROR
  class UnknownError < Error; end

  # Raised when API returns ZERO_RESULTS
  class ZeroResults < Error; end

  # Raised when API returns OVER_QUERY_LIMIT or 403 HTTP code
  class OverQueryLimit < Error; end
end
