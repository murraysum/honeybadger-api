module Honeybadger
  module Read
    class TeamInvitation

      attr_reader :id, :token, :email, :created_by, :accepted_by, :created_at, :accepted_at, :message

      def initialize(opts)
        @id = opts[:id]
        @token = opts[:token]
        @email = opts[:email]
        @created_by = User.new(opts[:created_by][:name], opts[:created_by][:email])
        @accepted_by = User.new(opts[:accepted_by][:name], opts[:accepted_by][:email])
        @admin = opts[:admin]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
        @accepted_at = opts[:accepted_at].nil? ? nil : DateTime.parse(opts[:accepted_at])
        @message = opts[:message]
      end

      def admin?
        @admin
      end

      def self.all(team_id)
        raise Exception.new("Not implemented")
      end

      def self.find(team_id, team_invitation_id)
        instance = Honeybadger::Read.client.get("teams/#{team_id}/team_invitations/#{team_invitation_id}")
        TeamInvitation.new(instance)
      end
    end
  end
end