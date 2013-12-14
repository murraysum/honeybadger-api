module Honeybadger
  module Read
    class TeamInvitation

      attr_reader :id, :token, :email, :created_by, :accepted_by, :admin, :created_at, :accepted_at, :message

      def initialize(id, token, email, created_by, accepted_by, admin, created_at, accepted_at, message)
        @id = id
        @token = token
        @email = email
        @created_by = created_by
        @accepted_by = accepted_by
        @admin = admin
        @created_at = created_at
        @accepted_at = accepted_at
        @message = message
      end

      def self.all(team_id)
        raise Exception.new("Not implemented")
      end

      def self.find(team_id, team_invitation_id)
        instance = Honeybadger::Read.client.get("teams/#{team_id}/team_invitation_id/#{team_invitation_id}")
        map(instance)
      end

      def self.map_collection(collection)
        collection.collect { |instance| map(instance) }
      end

      def self.map(instance)
        TeamInvitation.new(
          instance[:id],
          instance[:token],
          instance[:email],
          instance[:created_by],
          instance[:accepted_by],
          instance[:admin],
          instance[:created_at],
          instance[:accepted_at],
          instance[:message]
        )
      end
    end
  end
end