require "honeybadger-read-api/version"
require "honeybadger-read-api/team"
require "honeybadger-read-api/team_member"
require "honeybadger-read-api/user"
require "honeybadger-read-api/api"
require "honeybadger-read-api/deploy"
require "honeybadger-read-api/team_invitation"
require "honeybadger-read-api/comment"
require "honeybadger-read-api/integration"
require "honeybadger-read-api/project"

module Honeybadger
  module Read

    class << self
      
      attr_reader :client

      def access_token(token)
        @client = Honeybadger::Read::Api.new(token)
      end
    end
  end
end
