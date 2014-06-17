module Honeybadger
  module Read
    class User

      attr_reader :name, :email

      # Public: Build a new instance of User 
      #
      # name - the name of the user
      # email - the email address of the user
      #
      # Returns a new User
      def initialize(name, email)
        @name = name
        @email = email
      end
    end
  end
end