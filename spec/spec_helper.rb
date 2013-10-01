require 'simplecov'
require 'coveralls'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
  SimpleCov::Formatter::HTMLFormatter,
  Coveralls::SimpleCov::Formatter
]

SimpleCov.start do
  add_filter 'spec'
  add_filter 'lib/lieu/response'
end

require 'rspec'
require 'vcr'
require 'json'
require 'webmock/rspec'
require 'lieu'

Dir['./spec/support/**/*.rb'].each { |f| require f }

WebMock.disable_net_connect!(allow: 'coveralls.io')

VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.filter_sensitive_data('<API_KEY>') do
    test_api_key
  end
  c.configure_rspec_metadata!
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

def stub_get(url)
  stub_request(:get, google_places_url(url))
end

def stub_post(url)
  stub_request(:post, google_places_url(url))
end

def google_places_url(url)
  "https://maps.googleapis.com/maps/api/place/#{url}/json?key=#{test_api_key}&sensor=false"
end

def place_reference
  'CmRYAAAAciqGsTRX1mXRvuXSH2ErwW-jCINE1aLiwP64MCWDN5vkXvXoQGPKldMfmdGyqWS'\
    'pm7BEYCgDm-iv7Kc2PF7QA7brMAwBbAcqMr5i1f4PwTpaovIZjysCEZTry8Ez30wpEhCN'\
    'CXpynextCld2EBsDkRKsGhSLayuRyFsex6JA6NPh9dyupoTH3g'
end

def json_content_type
  { 'Content-type' => 'application/json' }
end

def test_api_key
  ENV.fetch('GOOGLE_PLACES_API_KEY', 'test_api_key')
end

def client
  Lieu.new(api_key: test_api_key)
end
