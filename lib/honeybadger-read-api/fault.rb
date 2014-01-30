module Honeybadger
  module Read
    class Fault

      attr_reader :id, :project_id, :klass, :action, :component, :message,
        :environment, :notices_count, :comments_count, :last_notice_at, :created_at

      def initialize(opts)
        @id = opts[:id]
        @project_id = opts[:project_id]
        @klass = opts[:klass]
        @action = opts[:action]
        @component = opts[:component]
        @message = opts[:message]
        @environment = opts[:environment]
        @ignored = opts[:ignored]
        @resolved = opts[:resolved]
        @notices_count = opts[:notices_count]
        @comments_count = opts[:comments_count]
        @last_notice_at = opts[:last_notice_at].nil? ? nil : DateTime.parse(opts[:last_notice_at])
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Whether tha fault has been marked as ignored.
      def ignored?
        @ignored == true
      end

      # Public: Whether tha fault has been marked as resolved.
      def resolved?
        @resolved == true
      end

      # Public: Find all faults for a given project.
      #
      # Examples:
      #    Honeybadger::Read::Fault.all(project_id)
      #
      def self.all(project_id, options = {})
        path = "projects/#{project_id}/faults"
        response = Honeybadger::Read.client.get(path, options)
        Honeybadger::Read::Paginator.new(self, path, response)
      end

      # Public: Find a fault for a given project.
      #
      # Examples:
      #    Honeybadger::Read::Fault.find(project_id, fault_id)
      #
      def self.find(project_id, fault_id)
        path = "projects/#{project_id}/faults/#{fault_id}"
        instance = Honeybadger::Read.client.get(path)
        Fault.new(instance)
      end
    end
  end
end