module Lieu
  class Client
    # Methods for the Place Photos API
    #
    # @see https://developers.google.com/places/documentation/photos
    module Photos
      # Get a photo.
      # @param photo_reference [String] the photo reference
      # @param options [Hash] a customizable set of options
      # @option options [String] :maxheight the maximum desired height in pixels
      # @option options [String] :maxwidth the maximum desired width in pixels
      # @return [String] the raw image
      # @see https://developers.google.com/places/documentation/photos#place_photo_requests
      # @example
      #   Lieu.photo('photo_reference', maxheight: '15', maxwidth: '15')
      def photo(photo_reference, options={})
        options.merge!(photoreference: photo_reference, json: false)

        get('photo', options)
      end
    end
  end
end
