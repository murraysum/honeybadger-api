module Honeybadger
  module Read
    class Environment

      attr_reader :id, :name, :project_id, :updated_at, :created_at

      # Public: Build a new instance of Environment
      #
      # opts - A Hash of attributes to initialize a Environment
      #
      # Returns a new Environment
      def initialize(opts)
        @id = opts[:id]
        @name = opts[:name]
        @notifications = opts[:notifications]
        @project_id = opts[:project_id]
        @updated_at = opts[:updated_at].nil? ? nil : DateTime.parse(opts[:updated_at])
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Whether notification are raised.
      def notifications?
        @notifications
      end
    end
  end
end