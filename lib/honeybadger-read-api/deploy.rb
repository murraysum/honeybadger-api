module Honeybadger
  module Read
    class Deploy

      attr_reader :id, :project_id, :repository, :revision, :environment, :local_username, :created_at

      def initialize(id, project_id, repository, revision, environment, local_username, created_at)
        @id = id
        @project_id = project_id
        @repository = repository
        @revision = revision
        @environment = environment
        @local_username = local_username
        @created_at = created_at
      end

      def self.all(project_id)
        raise Exception.new("Not implemented")
      end

      def self.find(project_id, deploy_id)
        instance = Honeybadger::Read.client.get("projects/#{project_id}/deploys/#{deploy_id}")
        map(instance)
      end

      def self.map_collection(collection)
        collection.collect { |instance| map(instance) }
      end

      def self.map(instance)
        Deploy.new(
          instance[:id],
          instance[:project_id],
          instance[:repository],
          instance[:revision],
          instance[:environment],
          instance[:local_username],
          instance[:created_at]
        )
      end
    end
  end
end