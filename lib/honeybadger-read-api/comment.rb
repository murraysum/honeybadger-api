module Honeybadger
  module Read
    class Comment

      attr_reader :id, :fault_id, :event, :source, :notices_count, :author, :body, :created_at

      def initialize(id, fault_id, event, source, notices_count, author, body, created_at)
        @id = id
        @fault_id = fault_id
        @event = event
        @source = source
        @notices_count = notices_count
        @author = author
        @body = body
        @created_at = created_at 
      end

      def self.all(project_id, fault_id)
        raise Exception.new("Not implemented")
      end

      def self.find(project_id, fault_id, comment_id)
        instance = Honeybadger::Read.client.get("projects/#{project_id}/faults/#{fault_id}/comments/#{comment_id}")
        map(instance)
      end

      def self.map_collection(collection)
        collection.collect { |instance| map(instance) }
      end

      def self.map(instance)
        Comment.new(
          instance[:id],
          instance[:fault_id],
          instance[:event],
          instance[:source],
          instance[:notices_count],
          instance[:author],
          instance[:body],
          instance[:created_at]
        )
      end
    end
  end
end