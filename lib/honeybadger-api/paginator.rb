module Honeybadger
  module Api
    class Paginator

      attr_reader :current_page, :pages, :next_page_link, :prev_page_link

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
          encoded_query = URI.parse(@next_page_link).query
          decoded_query = URI.decode_www_form(encoded_query)
          next_page_filters = decoded_query.inject({}){ |h,(k,v)| h[k.to_sym] = v; h }

          response = Honeybadger::Api.client.get(@path, @filters.merge(next_page_filters))

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
          encoded_query = URI.parse(@prev_page_link).query
          decoded_query = URI.decode_www_form(encoded_query)
          prev_page_filters = decoded_query.inject({}){ |h,(k,v)| h[k.to_sym] = v; h }

          response = Honeybadger::Api.client.get(@path, @filters.merge(prev_page_filters))

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
