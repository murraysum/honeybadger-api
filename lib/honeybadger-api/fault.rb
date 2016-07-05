module Honeybadger
  module Api
    class Fault

      attr_reader :id, :project_id, :klass, :action, :component, :message, :assignee,
        :environment, :notices_count, :comments_count, :last_notice_at, :created_at, :ignored,
        :resolved

      # Public: Build a new instance of Fault
      #
      # opts - A Hash of attributes to initialize a Fault
      #
      # Returns a new Fault
      def initialize(opts)
        @id = opts[:id]
        @project_id = opts[:project_id]
        @klass = opts[:klass]
        @action = opts[:action]
        @component = opts[:component]
        @message = opts[:message],
        @assignee = opts[:assignee],
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
      def self.all(project_id)
        path  = "projects/#{project_id}/faults"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all faults for a given project.
      def self.paginate(project_id, filters = {})
        path  = "projects/#{project_id}/faults"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Public: Find a fault for a given project.
      def self.find(project_id, fault_id)
        path = "projects/#{project_id}/faults/#{fault_id}"
        Honeybadger::Api::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| Fault.new(response) }
      end
    end
  end
end
