module Honeybadger
  module Read
    class Configuration

      attr_accessor :access_token

      def initialize
        @access_token = nil
      end
    end
  end
end