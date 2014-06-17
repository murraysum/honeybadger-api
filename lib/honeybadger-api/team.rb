module Honeybadger
  module Api
    class Team

      attr_reader :id, :name, :owner, :team_members, :projects, :created_at

      # Public: Build a new instance of Team
      #
      # opts - A Hash of attributes to initialize a Team
      #
      # Returns a new Team
      def initialize(opts)
        @id = opts[:id]
        @name = opts[:name]
        @owner = User.new(opts[:owner][:name], opts[:owner][:email])
        @team_members = opts[:members].collect { |m| TeamMember.new(m) }
        @projects = opts[:projects].collect { |p| Project.new(p) }
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Find all of the teams.
      def self.all
        Honeybadger::Api::Request.all("teams", handler)
      end

      # Public: Paginate all of the teams.
      def self.paginate(filters = {})
        Honeybadger::Api::Request.paginate("teams", handler, filters)
      end

      # Public: Find a team.
      def self.find(team_id)
        Honeybadger::Api::Request.find("teams/#{team_id}", handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| Team.new(response) }
      end
    end
  end
end