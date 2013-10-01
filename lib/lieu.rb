require 'lieu/configuration'
require 'lieu/client'

# Ruby wrapper for Google Places
module Lieu
  extend Configuration

  class << self
    # Delegates to Lieu::Client#new
    def new(options={})
      Lieu::Client.new(options)
    end

    # @private
    def method_missing(method, *args, &block)
      return super unless new.respond_to?(method)
      new.send(method, *args, &block)
    end

    # @private
    def respond_to?(method, include_private=false)
      new.respond_to?(method, include_private) || super(method, include_private)
    end
  end
end
