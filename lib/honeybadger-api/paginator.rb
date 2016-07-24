module Honeybadger
  module Api
    class Paginator

      attr_reader :current_page, :pages

      def initialize(path, filters, handler)
        @path = path
        @filters = filters
        @handler = handler

        @pages = {}

        @filters.merge!({ :page => 1 }) if !@filters.has_key?(:page)
        @current_page = @filters[:page]

        response = Honeybadger::Api.client.get(@path, @filters)

        @next_page_link = response[:links][:next]
        @prev_page_link = response[:links][:prev]

        @pages[current_page] = response[:results].map do |r|
          @handler.call(r)
        end
      end

      def next?
        !@next_page_link.nil?
      end

      def previous?
        !@prev_page_link.nil?
      end

      def next
        if next?
          response = Honeybadger::Api.client.get(@path, @filters.merge({:page => current_page + 1}))

          @current_page = current_page + 1

          @next_page_link = response[:links][:next]
          @prev_page_link = response[:links][:prev]

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

          @current_page = current_page - 1

          @next_page_link = response[:links][:next]
          @prev_page_link = response[:links][:prev]

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
