# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'honeybadger-api/version'

Gem::Specification.new do |spec|
  spec.name          = "honeybadger-api"
  spec.version       = Honeybadger::Api::VERSION
  spec.authors       = ["Murray Summers"]
  spec.email         = ["murray.sum@gmail.com"]
  spec.description   = %q{Retrieve data from the Honeybadger Read API}
  spec.summary       = %q{Honeybadger Read API}
  spec.homepage      = "https://github.com/murraysum/honeybadger-api"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'json'

  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'mocha'
  spec.add_development_dependency 'factory_girl'
end
