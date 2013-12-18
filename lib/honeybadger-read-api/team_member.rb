module Honeybadger
  module Read
    class TeamMember

      attr_reader :id, :name, :email, :admin, :created_at

      def initialize(opts)
        @id = opts[:id]
        @name = opts[:name]
        @email = opts[:email]
        @admin = opts[:admin]
        @created_at = opts[:created_at]
      end

      def admin?
        @admin
      end

      def self.all(team_id)
        raise Exception.new("Not implemented")
      end

      def self.find(team_id, team_member_id)
        instance = Honeybadger::Read.client.get("teams/#{team_id}/team_members/#{team_member_id}")
        TeamMember.new(instance)
      end
    end
  end
end