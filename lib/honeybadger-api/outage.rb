module Honeybadger
  module Api
    class Outage

      attr_reader :down_at, :up_at, :created_at, :status, :reason, :headers

      # Public: Build a new instance of Outage
      #
      # opts - A Hash of attributes to initialize an Outage
      #
      # Returns a new Outage
      def initialize(opts)
        @down_at = opts[:down_at].nil? ? nil : DateTime.parse(opts[:down_at])
        @up_at = opts[:up_at].nil? ? nil : DateTime.parse(opts[:up_at])
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
        @status = opts[:status]
        @reason = opts[:reason]
        @headers = opts[:headers]
      end

      # Public: Find all outages for a given project and site.
      def self.all(project_id, site_id)
        path = "projects/#{project_id}/sites/#{site_id}/outages"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all outages for a given project and site.
      def self.paginate(project_id, site_id, filters = {})
        path = "projects/#{project_id}/sites/#{site_id}/outages"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| Outage.new(response) }
      end
    end
  end
end
