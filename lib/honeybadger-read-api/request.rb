module Honeybadger
  module Read
    class Request

      def initialize
        @type = nil
        @path = nil
        @filters = {}
        @handler = nil
      end

      def self.build
        request = Honeybadger::Read::Request.new
        yield request
        request
      end

      def self.perform
        request = Honeybadger::Read::Request.build do |request|
          yield request
        end
        request.perform
      end

      def type(type)
        @type = type
      end

      def path(path)
        @path = path
      end

      def filters(filters)
        @filters = filters
      end

      def handler
        @handler = Proc.new { |instance| yield instance }
      end

      def perform
        response = Honeybadger::Read.client.get(@path)
        @handler.call(response)
      end
    end
  end
end