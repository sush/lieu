![Lieu](https://raw.github.com/sush/lieu/master/lieu.png)

> The word *lieu* originally comes from the Latin *locus*, meaning *place*, and its meaning has stayed true to its origins ever since.

Simple Ruby wrapper for the [Google Places API](https://developers.google.com/places/documentation).

**Current version**: [![Gem Version](https://badge.fury.io/rb/lieu.png)](http://badge.fury.io/rb/lieu)

**Build status**: &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Build Status](https://secure.travis-ci.org/Sush/lieu.png?branch=master)](http://travis-ci.org/Sush/lieu)

**Code metrics**:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;[![Code Climate](https://codeclimate.com/github/Sush/lieu.png)](https://codeclimate.com/github/Sush/lieu)
[![Coverage Status](https://coveralls.io/repos/Sush/lieu/badge.png?branch=master)](https://coveralls.io/r/Sush/lieu?branch=master)

**Ruby support**:

- 1.9.2
- 1.9.3
- 2.0.0

## Installation

Install via Rubygems

    gem install lieu

or add to your Gemfile

    gem 'lieu', '~> 1.0'

### Configuration

API methods are available as module methods

```ruby
Lieu.configure do |c|
  c.api_endpoint = 'http://newendpoint/'
  c.api_key = 'YOUR_API_KEY'
  c.sensor = true
end
```

or as client instance methods

```ruby
Lieu::Client.new(
	api_endpoint: 'http://newendpoint/',
	api_key: 'YOUR_API_KEY',
	sensor: true
)
```

The `sensor` parameter can be set globally (default to `false`) or can be provided for every request by passing the optional parameter `sensor: true`.

## Authentication

Lieu only supports authentication via an API key.

You can request one following these [steps](https://developers.google.com/places/documentation/#Authentication).

## Usage


```ruby
place = Lieu.details('CmRYAAAA...')
puts place.name
# => "Google Sydney"

places = Lieu.text_search('Google Sydney')
places.first.formatted_address
# => "529 Kent Street, Sydney NSW, Australia"

# etc…
```

## Features

Lieu supports all the Google Places API methods:

- [Search](http://rubydoc.info/gems/lieu/Lieu/Client/Search)
- [Details](http://rubydoc.info/gems/lieu/Lieu/Client/Details)
- [Actions](http://rubydoc.info/gems/lieu/Lieu/Client/Actions)
- [Photos](http://rubydoc.info/gems/lieu/Lieu/Client/Photos)
- [Autocomplete](http://rubydoc.info/gems/lieu/Lieu/Client/Autocomplete)
- [Query autocomplete](http://rubydoc.info/gems/lieu/Lieu/Client/QueryAutocomplete)

Complete Lieu public API's documentation [here](http://rubydoc.info/gems/lieu/frames).


## Similar libraries

- [google_places](https://github.com/marceldegraaf/google_places)

## Versioning
Lieu follows the principles of [semantic versioning](http://semver.org).

1. Patch level releases contain only bug fixes.
2. Minor releases contain backward-compatible new features.
3. Major new releases contain backwards-incompatible changes to the public API.

## Contributing

Pull Requests are welcome !

Please refer to the [Contributing guide](https://github.com/sush/lieu/master/CONTRIBUTING.md) for more details on how to run the test suite and to contribute.


## Copyright

Copyright © 2013 Aylic Petit

Released under the terms of the MIT licence. See the [LICENSE](https://github.com/sush/lieu/master/LICENSE) file for more details.
