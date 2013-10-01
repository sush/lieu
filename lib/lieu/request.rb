module Lieu
  # Methods for HTTP requests
  module Request
    # Make a HTTP GET request.
    #
    # @param path [String] The path, relative to api_endpoint
    # @param options [Hash] query params for request
    # @return [Hashie::Mash]
    def get(path, options={})
      request(:get, path, options)
    end

    # Make a HTTP POST request.
    #
    # @param path [String] The path, relative to api_endpoint
    # @param options [Hash] body params for request
    # @return [Hashie::Mash]
    def post(path, options={})
      response = request(:post, path, options)

      response.delete(:status) if response.respond_to?(:status)

      response
    end

    private

    def request(method, path, options)
      path = "#{path}/json" unless options.delete(:json) == false

      response = connection.send(method) do |request|
        request.params['key'] = self.api_key
        request.params['sensor'] = options.delete(:sensor) || self.sensor

        case method
        when :get
          request.url(path, options)
        when :post
          request.path = path
          request.body = MultiJson.dump(options) unless options.empty?
        end
      end

      response.body
    end

    def boolean_from_response(method, path, options={})
      response = request(method, path, options)

      response.status == 'OK'
    end
  end
end
