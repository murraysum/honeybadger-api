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
        raise Exception.new("Not implemented")
      end

      def self.find(team_id)
        instance = Honeybadger::Read.client.get("teams/#{team_id}")
        Team.new(instance)
      end
    end
  end
end