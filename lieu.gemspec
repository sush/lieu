# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lieu/version'

Gem::Specification.new do |gem|
  gem.name = 'lieu'
  gem.version = Lieu::VERSION.dup
  gem.license = 'MIT'

  gem.summary = %q{Google Places API Ruby wrapper}
  gem.description = %q{Simple Ruby wrapper for the Google places API.}
  gem.homepage = 'https://github.com/sush/lieu'

  gem.authors = ['Aylic Petit']
  gem.email = ['sush@users.noreply.github.com']

  gem.required_ruby_version = '>= 1.9.2'

  gem.files = %w[.yardopts LICENSE README.md CONTRIBUTING.md Rakefile lieu.gemspec]
  gem.files += Dir.glob('{spec,lib}/**/*.rb')
  gem.require_paths = ['lib']
  gem.test_files = Dir.glob('spec/**/*')

  gem.add_development_dependency 'bundler', '~> 1.0'
  gem.add_dependency 'faraday', '~> 0.8.8'
  gem.add_dependency 'faraday_middleware', '~> 0.9.0'
  gem.add_dependency 'hashie', '~>2.0.5'
  gem.add_dependency 'json', '~>1.8.0'
  gem.add_dependency 'multi_json', '~>1.8.0'
end
