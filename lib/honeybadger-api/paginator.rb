module Honeybadger
  module Api
    class Paginator

      attr_reader :current_page, :total_page_count, :pages

      def initialize(path, filters, handler)
        @path = path
        @filters = filters
        @handler = handler

        @pages = {}

        @filters.merge!({ :page => 1 }) if !@filters.has_key?(:page)
        response = Honeybadger::Api.client.get(@path, @filters)

        @current_page = response[:current_page]
        @total_page_count = response[:num_pages]

        @pages[current_page] = response[:results].map do |r|
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
          response = Honeybadger::Api.client.get(@path, @filters.merge({:page => current_page + 1}))

          @current_page = response[:current_page]
          @total_page_count = response[:num_pages]

          @pages[current_page] = response[:results].map do |r|
            @handler.call(r)
          end

          @pages[current_page]
        else
          nil
        end
      end

      def previous
        if previous?
          response = Honeybadger::Api.client.get(@path, @filters.merge({:page => current_page - 1}))

          @current_page = response[:current_page]
          @total_page_count = response[:num_pages]

          @pages[current_page] = response[:results].map do |r|
            @handler.call(r)
          end

          @pages[current_page]
        else
          nil
        end
      end

      def collection
        @pages.values.flatten
      end
    end
  end
end
