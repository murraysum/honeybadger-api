module Honeybadger
  module Api
    class Comment

      attr_reader :id, :fault_id, :event, :source, :notices_count, :author, :body, :email, :created_at

      # Public: Build a new instance of Comment
      #
      # opts - A Hash of attributes to initialize a Comment
      #
      # Returns a new Comment
      def initialize(opts)
        @id = opts[:id]
        @fault_id = opts[:fault_id]
        @event = opts[:event]
        @source = opts[:source]
        @notices_count = opts[:notices_count]
        @author = opts[:author]
        @body = opts[:body]
        @email = opts[:email]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Find all comments on a fault for a project.
      def self.all(project_id, fault_id)
        path = "projects/#{project_id}/faults/#{fault_id}/comments"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all comments on a fault for a project
      def self.paginate(project_id, fault_id, filters = {})
        path = "projects/#{project_id}/faults/#{fault_id}/comments"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Public: Find a comment on a fault for a project.
      def self.find(project_id, fault_id, comment_id)
        path = "projects/#{project_id}/faults/#{fault_id}/comments/#{comment_id}"
        Honeybadger::Api::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| Comment.new(response) }
      end
    end
  end
end