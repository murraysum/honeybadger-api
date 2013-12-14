module Honeybadger
  module Read
    class User

      attr_reader :name, :email

      def initialize(name, email)
        @name = name
        @email = email
      end

      def self.map(instance)
        User.new(
          instance[:name],
          instance[:email]
        )
      end
    end
  end
end