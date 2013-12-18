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
        @created_at = opts[:created_at]
      end

      def self.all(project_id, fault_id)
        raise Exception.new("Not implemented")
      end

      def self.find(project_id, fault_id, comment_id)
        instance = Honeybadger::Read.client.get("projects/#{project_id}/faults/#{fault_id}/comments/#{comment_id}")
        Comment.new(instance)
      end
    end
  end
end