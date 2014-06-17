module Honeybadger
  module Api
    class TeamMember

      attr_reader :id, :admin, :created_at

      # Public: Build a new instance of TeamMember
      #
      # opts - A Hash of attributes to initialize a TeamMember
      #
      # Returns a new TeamMember
      def initialize(opts)
        @id = opts[:id]
        @user = User.new(opts[:name], opts[:email])
        @admin = opts[:admin]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Whether the team member is an admin
      def admin?
        @admin
      end

      # Public: The name of the team member
      def name
        @user.name
      end

      # Public: The email address of the team member
      def email
        @user.email
      end

      # Public: Find all team members for a team.
      def self.all(team_id)
        path = "teams/#{team_id}/team_members"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all team members for a team.
      def self.paginate(team_id, filters = {})
        path = "teams/#{team_id}/team_members"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Public: Find a team member for a given team.
      def self.find(team_id, team_member_id)
        path = "teams/#{team_id}/team_members/#{team_member_id}"
        Honeybadger::Api::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| TeamMember.new(response) }
      end
    end
  end
end