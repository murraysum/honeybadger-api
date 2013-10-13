module Honeybadger
  module Read
    class TeamMember

      attr_reader :id, :name, :email, :admin, :created_at

      def initialize(id, name, email, admin, created_at)
        @id = id
        @name = name
        @email = email
        @admin = admin
        @created_at = created_at
      end

      def admin?
        @admin
      end

      def self.all(team_id)
        raise Exception.new("Not implemented")
      end

      def self.find(team_id, team_member_id)
        instance = Honeybadger::Read.client.get("teams/#{team_id}/team_members/#{team_member_id}")
        map(instance)
      end

      def self.map_collection(collection)
        collection.collect { |instance| map(instance) }
      end

      def self.map(instance)
        TeamMember.new(
          instance[:id],
          instance[:name],
          instance[:email],
          instance[:admin],
          instance[:created_at]
        )
      end
    end
  end
end