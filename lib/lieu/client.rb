require 'lieu/connection'
require 'lieu/request'

require 'lieu/client/details'
require 'lieu/client/search'
require 'lieu/client/autocomplete'
require 'lieu/client/query_autocomplete'
require 'lieu/client/photos'
require 'lieu/client/actions'

module Lieu
  # Client for the Google Places API
  #
  # @see https://developers.google.com/places/documentation
  class Client
    attr_accessor(*Configuration::VALID_OPTIONS)

    def initialize(options={})
      options = Lieu.options.merge(options)

      Configuration::VALID_OPTIONS.each do |key|
        send("#{key}=", options[key])
      end
    end

    include Lieu::Connection
    include Lieu::Request

    include Lieu::Client::Details
    include Lieu::Client::Search
    include Lieu::Client::Autocomplete
    include Lieu::Client::QueryAutocomplete
    include Lieu::Client::Photos
    include Lieu::Client::Actions
  end
end
