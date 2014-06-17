module Honeybadger
  module Api
    class TeamInvitation

      attr_reader :id, :token, :email, :created_by, :accepted_by, :created_at, :accepted_at, :message

      # Public: Build a new instance of TeamInvitation
      #
      # opts - A Hash of attributes to initialize a TeamInvitation
      #
      # Returns a new TeamInvitation
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

      # Public: Whether the invitation was for an admin user.
      def admin?
        @admin
      end

      # Public: Find all team invitations for a team.
      def self.all(team_id)
        path = "teams/#{team_id}/team_invitations"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all team invitations for a team.
      def self.paginate(team_id, filters = {})
        path = "teams/#{team_id}/team_invitations"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Public: Find a team invitation for a given team.
      def self.find(team_id, team_invitation_id)
        path = "teams/#{team_id}/team_invitations/#{team_invitation_id}"
        Honeybadger::Api::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| TeamInvitation.new(response) }
      end
    end
  end
end