module Honeybadger
  module Read
    class Response

      attr_reader :current_page, :total_page_count

      def initialize(klass, opts)
        @current_page = opts[:current_page]
        @total_page_count = opts[:num_pages]
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

      def items
        @items
      end
    end
  end
end