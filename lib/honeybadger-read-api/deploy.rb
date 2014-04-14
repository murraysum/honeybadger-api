module Honeybadger
  module Read
    class Deploy

      attr_reader :id, :project_id, :repository, :revision, :environment, :local_username, :created_at

      def initialize(opts)
        @id = opts[:id]
        @project_id = opts[:project_id]
        @repository = opts[:repository]
        @revision = opts[:revision]
        @environment = Environment.new(opts[:environment])
        @local_username = opts[:local_username]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Find all deploys for a given project.
      #
      # Examples:
      #    Honeybadger::Read::Deploy.all(project_id)
      #
      def self.all(project_id)
        path = "projects/#{project_id}/deploys"
        response = Honeybadger::Read.client.get(path)
        Honeybadger::Read::Paginator.new(self, path, response)
      end

      # Public: Find a deploy for a given project.
      #
      # Examples:
      #    Honeybadger::Read::Deploy.find(project_id, deploy_id)
      #
      def self.find(project_id, deploy_id)
        path = "projects/#{project_id}/deploys/#{deploy_id}"
        instance = Honeybadger::Read.client.get(path)
        Deploy.new(instance)
      end
    end
  end
end