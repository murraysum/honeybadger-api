module Honeybadger
  module Read
    class Integration

      attr_reader :name, :integration_id

      def initialize(name, integration_id)
        @name = name
        @integration_id = integration_id
      end
    end
  end
end
