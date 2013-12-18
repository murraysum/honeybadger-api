module Honeybadger
  module Read
    class Deploy

      attr_reader :id, :project_id, :repository, :revision, :environment, :local_username, :created_at

      def initialize(opts)
        @id = opts[:id]
        @project_id = opts[:project_id]
        @repository = opts[:repository]
        @revision = opts[:revision]
        @environment = opts[:environment]
        @local_username = opts[:local_username]
        @created_at = opts[:created_at]
      end

      def self.all(project_id)
        raise Exception.new("Not implemented")
      end

      def self.find(project_id, deploy_id)
        instance = Honeybadger::Read.client.get("projects/#{project_id}/deploys/#{deploy_id}")
        Deploy.new(instance)
      end
    end
  end
end