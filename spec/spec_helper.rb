require 'rspec'
require 'webmock/rspec'
require 'mocha/api'
require 'factory_girl'
require 'honeybadger-api'

RSpec.configure do |config|
  config.color = true
  config.mock_framework = :mocha
end

FactoryGirl.find_definitions