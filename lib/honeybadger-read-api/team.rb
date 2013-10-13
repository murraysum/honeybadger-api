module Honeybadger
  module Read
    class Team

      def initialize(id, name, owner, team_members, projects, created_at) 
        @id = id
        @name = name
        @owner = owner
        @team_members = team_members
        @projects = projects
        @created_at = created_at
      end

      def self.all
        raise Exception.new("Not implemented")
      end

      def self.find(team_id)
        instance = Honeybadger::Read.client.get("teams/#{team_id}")
        map(instance)
      end

      def self.map_collection(collection)
        collection.collect { |instance| map(instance) }
      end

      def self.map(instance)
        owner = Owner.map(instance[:owner])
        team_members = TeamMember.map_collection(instance[:members])
        
        # TODO create a project mapping
        projects = instance[:projects]

        Team.new(
          instance[:id],
          instance[:name],
          owner,
          team_members,
          projects,
          instance[:created_at]
        )
      end
    end
  end
end