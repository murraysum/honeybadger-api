module Honeybadger
  module Read
    class Paginator

      attr_reader :current_page, :total_page_count

      def initialize(klass, path, opts)
        @current_page = opts[:current_page]
        @total_page_count = opts[:num_pages]
        @path = path
        @klass = klass
        @items = opts[:results].collect do |result|
          klass.new(result)
        end
      end

      def next?
        current_page < total_page_count
      end

      def previous?
        current_page > 1
      end

      def next
        response = Honeybadger::Read.client.get(@path, :page => current_page + 1)
        Honeybadger::Read::Paginator.new(@klass, @path, response)
      end

      def previous
        response = Honeybadger::Read.client.get(@path, :page => current_page - 1)
        Honeybadger::Read::Paginator.new(@klass, @path, response)
      end

      def items
        @items
      end
    end
  end
end
