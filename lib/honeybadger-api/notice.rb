module Honeybadger
  module Api
    class Notice

      attr_reader :id, :url, :fault_id, :environment, :environment_name, :cookies, :message,
       :request, :created_at, :web_environment, :backtrace

      # Public: Build a new instance of Notice
      #
      # opts - A Hash of attributes to initialize a Notice
      #
      # Returns a new Notice
      def initialize(opts)
        @id = opts[:id]
        @url = opts[:url]
        @fault_id = opts[:fault_id]
        @environment = opts[:environment]
        @environment_name = opts[:environment_name]
        @cookies = opts[:cookies]
        @web_environment = opts[:web_environment]
        @backtrace = opts[:backtrace]
        @message = opts[:message]
        @request = opts[:request]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Find all notices on a fault for a project.
      def self.all(project_id, fault_id)
        path = "projects/#{project_id}/faults/#{fault_id}/notices"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all notices on a fault for a project
      def self.paginate(project_id, fault_id, filters = {})
        path = "projects/#{project_id}/faults/#{fault_id}/notices"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Public: Find a notice on a fault for a project.
      def self.find(project_id, fault_id, notice_id)
        path = "projects/#{project_id}/faults/#{fault_id}/notices/#{notice_id}"
        Honeybadger::Api::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| Notice.new(response) }
      end
    end
  end
end