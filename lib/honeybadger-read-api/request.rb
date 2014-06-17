module Honeybadger
  module Read
    class Request

      def initialize(path, handler, filters = {})
        @path = path
        @handler = handler
        @filters = filters
      end

      def self.all(path, handler)
        request = Honeybadger::Read::Request.new(path, handler)
        request.all
      end

      def all
        paginator = Honeybadger::Read::Paginator.new(@path, @filters, @handler)
        while paginator.next?
          paginator.next
        end
        paginator.collection
      end

      def self.find(path, handler)
        request = Honeybadger::Read::Request.new(path, handler)
        request.find
      end

      def find
        response = Honeybadger::Read.client.get(@path)
        @handler.call(response)
      end

      def self.paginate(path, handler, filters)
        request = Honeybadger::Read::Request.new(path, handler, filters)
        request.paginate
      end

      def paginate
        Honeybadger::Read::Paginator.new(@path, @filters, @handler)
      end
    end
  end
end