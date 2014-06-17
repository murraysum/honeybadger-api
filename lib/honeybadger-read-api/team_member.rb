module Honeybadger
  module Read
    class TeamMember

      attr_reader :id, :admin, :created_at

      def initialize(opts)
        @id = opts[:id]
        @user = User.new(opts[:name], opts[:email])
        @admin = opts[:admin]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      def admin?
        @admin
      end

      def name
        @user.name
      end

      def email
        @user.email
      end

      def self.all(team_id)
        path = "teams/#{team_id}/team_members"
        Honeybadger::Read::Request.all(path, handler)
      end

      def self.paginate(team_id, filters = {})
        path = "teams/#{team_id}/team_members"
        Honeybadger::Read::Request.paginate(path, handler, filters)
      end

      def self.find(team_id, team_member_id)
        path = "teams/#{team_id}/team_members/#{team_member_id}"
        Honeybadger::Read::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| TeamMember.new(response) }
      end
    end
  end
end