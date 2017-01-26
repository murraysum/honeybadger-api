module Honeybadger
  module Api
    class Site

      attr_reader :active, :frequency, :id, :last_checked_at,
        :match, :match_type, :name, :state, :url

      # Public: Build a new instance of Site
      #
      # opts - A Hash of attributes to initialize a Site
      #
      # Returns a new Site
      def initialize(opts)
        @active = opts[:active]
        @frequency = opts[:frequency]
        @id = opts[:id]
        @last_checked_at = opts[:last_checked_at].nil? ? nil : DateTime.parse(opts[:last_checked_at])
        @match = opts[:match]
        @match_type = opts[:match_type]
        @name = opts[:name]
        @state = opts[:state]
        @url = opts[:url]
      end

      # Public: Find all sites for a given project.
      def self.all(project_id)
        path  = "projects/#{project_id}/sites"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all sites for a given project.
      def self.paginate(project_id, filters = {})
        path  = "projects/#{project_id}/sites"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Public: Find a site for a given project.
      def self.find(project_id, site_id)
        path = "projects/#{project_id}/sites/#{site_id}"
        Honeybadger::Api::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| Site.new(response) }
      end
    end
  end
end
