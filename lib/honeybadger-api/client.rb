require "net/http"
require "uri"
require "json"
require "openssl"

module Honeybadger
  module Api
    class Client
      
      attr_reader :access_token

      def initialize(access_token)
        @access_token = access_token
      end

      def get(path, options = {})
        response = request(path, options)
        JSON.parse(response.body, :symbolize_names => true)
      end

      private

      def request(path, options = {})
        uri = build_uri(path, options)
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_PEER

        request = Net::HTTP::Get.new(uri.request_uri)
        request.basic_auth(access_token, nil)

        response = http.request(request)
      end

      def build_uri(path, opts)
        uri = URI.join(host, path)
        uri.query = build_query(opts)
        uri
      end

      def build_query(opts)
        URI.encode_www_form(opts)
      end

      def host
        "https://api.honeybadger.io/v2/"
      end
    end
  end
end