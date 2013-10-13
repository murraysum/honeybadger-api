require 'rspec'
require 'webmock/rspec'
require 'mocha/api'
require 'factory_girl'
require 'honeybadger-read-api'

RSpec.configure do |config|
  config.color_enabled = true
  config.formatter = 'documentation'
  config.mock_framework = :mocha
end

FactoryGirl.find_definitions