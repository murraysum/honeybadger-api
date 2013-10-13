module Honeybadger
  module Read
    class Owner

      attr_reader :name, :email

      def initialize(name, email)
        @name = name
        @email = email
      end

      def self.map(instance)
        Owner.new(
          instance[:name],
          instance[:email]
        )
      end
    end
  end
end