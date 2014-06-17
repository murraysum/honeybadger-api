require 'date'

require "honeybadger-api/version"
require "honeybadger-api/configuration"
require "honeybadger-api/paginator"
require "honeybadger-api/request"
require "honeybadger-api/team"
require "honeybadger-api/team_member"
require "honeybadger-api/user"
require "honeybadger-api/client"
require "honeybadger-api/deploy"
require "honeybadger-api/team_invitation"
require "honeybadger-api/comment"
require "honeybadger-api/project"
require "honeybadger-api/fault"
require "honeybadger-api/notice"
require "honeybadger-api/environment"

module Honeybadger
  module Api

    # Public: Configure the HoneyBadger Read API and set
    # an access token to authenticate.
    #
    # Examples:
    #
    #  Honeybadger::Api.configure do |c|
    #    c.access_token = "xxxxxxxxxxxxxxxxxxxx"
    #  end
    def self.configure
      @configuration = Honeybadger::Api::Configuration.new
      yield @configuration
    end

    # Public: Query the HoneyBadger Read API directly.
    def self.client
      Honeybadger::Api::Client.new(@configuration.access_token)
    end

  end
end
