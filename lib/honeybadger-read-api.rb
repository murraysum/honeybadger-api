require 'date'

require "honeybadger-read-api/version"
require "honeybadger-read-api/configuration"
require "honeybadger-read-api/paginator"
require "honeybadger-read-api/request"
require "honeybadger-read-api/team"
require "honeybadger-read-api/team_member"
require "honeybadger-read-api/user"
require "honeybadger-read-api/api"
require "honeybadger-read-api/deploy"
require "honeybadger-read-api/team_invitation"
require "honeybadger-read-api/comment"
require "honeybadger-read-api/integration"
require "honeybadger-read-api/project"
require "honeybadger-read-api/fault"
require "honeybadger-read-api/notice"
require "honeybadger-read-api/environment"

module Honeybadger
  module Read

    # Public: Configure the HoneyBadger Read API and set
    # an access token to authenticate.
    #
    # Examples:
    #
    #  Honeybadger::Read.configure do |c|
    #    c.access_token = "xxxxxxxxxxxxxxxxxxxx"
    #  end
    def self.configure
      @configuration = Honeybadger::Read::Configuration.new
      yield @configuration
    end

    # Public: Query the HoneyBadger Read API directly.
    def self.client
      Honeybadger::Read::Api.new(@configuration.access_token)
    end

  end
end
