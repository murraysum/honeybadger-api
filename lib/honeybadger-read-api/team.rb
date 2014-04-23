module Honeybadger
  module Read
    class Team

      attr_reader :id, :name, :owner, :team_members, :projects, :created_at

      def initialize(opts)
        @id = opts[:id]
        @name = opts[:name]
        @owner = User.new(opts[:owner][:name], opts[:owner][:email])
        # TODO map all the team members and projects to objects
        @team_members = opts[:members]
        @projects = opts[:projects]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      def self.all
        path = "teams"
        response = Honeybadger::Read.client.get(path)
        Honeybadger::Read::Paginator.new(self, path, response)
      end

      def self.find(team_id)
        Honeybadger::Read::Request.perform do |request|
          request.path "teams/#{team_id}"
          request.handler { |response| Team.new(response) }
        end
      end
    end
  end
end