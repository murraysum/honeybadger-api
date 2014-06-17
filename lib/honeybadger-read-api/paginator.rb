module Honeybadger
  module Read
    class Paginator

      attr_reader :current_page, :total_page_count

      def initialize(path, filters, handler)
        @path = path
        @filters = filters
        @handler = handler

        @collection = {}

        @filters.merge!({ :page => 1 }) if !@filters.has_key?(:page)
        response = Honeybadger::Read.client.get(@path, @filters)

        @current_page = response[:current_page]
        @total_page_count = response[:num_pages]

        @collection[current_page] = response[:results].map do |r|
          @handler.call(r)
        end
      end

      def next?
        current_page < total_page_count
      end

      def previous?
        current_page > 1
      end

      def next
        if next?
          response = Honeybadger::Read.client.get(@path, @filters.merge({:page => current_page + 1}))

          @current_page = response[:current_page]
          @total_page_count = response[:num_pages]

          @collection[current_page] = response[:results].map do |r|
            @handler.call(r)
          end

          @collection[current_page]
        else
          nil
        end
      end

      def previous
        if previous?
          response = Honeybadger::Read.client.get(@path, @filters.merge({:page => current_page - 1}))

          @current_page = response[:current_page]
          @total_page_count = response[:num_pages]

          @collection[current_page] = response[:results].map do |r|
            @handler.call(r)
          end

          @collection[current_page]
        else
          nil
        end
      end

      def collection
        @collection.values.flatten
      end
    end
  end
end
