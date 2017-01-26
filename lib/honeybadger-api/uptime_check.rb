module Honeybadger
  module Api
    class UptimeCheck

      attr_reader :up, :location, :duration, :created_at

      # Public: Build a new instance of UptimeCheck
      #
      # opts - A Hash of attributes to initialize a UptimeCheck
      #
      # Returns a new UptimeCheck
      def initialize(opts)
        @up = opts[:up]
        @location = opts[:location]
        @duration = opts[:duration]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Find all uptime checks for a given project and site.
      def self.all(project_id, site_id)
        path = "projects/#{project_id}/sites/#{site_id}/uptime_checks"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all uptime checks for a given project and site.
      def self.paginate(project_id, site_id, filters = {})
        path = "projects/#{project_id}/sites/#{site_id}/uptime_checks"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| UptimeCheck.new(response) }
      end
    end
  end
end
