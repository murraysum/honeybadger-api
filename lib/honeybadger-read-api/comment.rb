module Honeybadger
  module Read
    class Comment

      attr_reader :id, :fault_id, :event, :source, :notices_count, :author, :body, :created_at

      def initialize(opts)
        @id = opts[:id]
        @fault_id = opts[:fault_id]
        @event = opts[:event]
        @source = opts[:source]
        @notices_count = opts[:notices_count]
        @author = opts[:author]
        @body = opts[:body]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Find all comments on a fault for a project.
      #
      # Examples:
      #    Honeybadger::Read::Comment.all(project_id, fault_id)
      #
      def self.all(project_id, fault_id)
        path = "projects/#{project_id}/faults/#{fault_id}/comments"
        response = Honeybadger::Read.client.get(path)
        Honeybadger::Read::Response.new(self, response)
      end

      # Public: Find a comment on a fault for a project.
      #
      # Examples:
      #    Honeybadger::Read::Comment.find(project_id, fault_id, comment_id)
      #
      def self.find(project_id, fault_id, comment_id)
        path = "projects/#{project_id}/faults/#{fault_id}/comments/#{comment_id}"
        instance = Honeybadger::Read.client.get(path)
        Comment.new(instance)
      end
    end
  end
end