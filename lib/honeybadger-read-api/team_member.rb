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
        response = Honeybadger::Read.client.get(path)
        Honeybadger::Read::Paginator.new(self, path, response)
      end

      def self.find(team_id, team_member_id)
        Honeybadger::Read::Request.perform do |request|
          request.path "teams/#{team_id}/team_members/#{team_member_id}"
          request.handler { |response| TeamMember.new(response) }
        end
      end
    end
  end
end