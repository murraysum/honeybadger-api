require 'net/http'
require 'uri'
require 'json'

module Honeybadger
  module Read
    class Api
      
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
        uri = URI.join(Api.site, path, "?auth_token=#{access_token}")
        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE

        request = Net::HTTP::Get.new(uri.request_uri)

        response = http.request(request)
      end

      def self.site
        "https://api.honeybadger.io/v1/"
      end
    end
  end
end