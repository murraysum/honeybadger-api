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
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Find all deploys for a given project.
      #
      # Examples:
      #    Honeybadger::Read::Deploy.all(project_id)
      #
      def self.all(project_id)
        path = "projects/#{project_id}/deploys"
        Honeybadger::Read::Request.all(path, handler)
      end

      # Public: Paginate all deploys for a given project
      #
      # Examples:
      #     Honeybadger::Read::Deploy.paginate(project_id, :page => 10)
      #
      def self.paginate(project_id, filters = {})
        path = "projects/#{project_id}/deploys"
        Honeybadger::Read::Request.paginate(path, handler, filters)
      end

      # Public: Find a deploy for a given project.
      #
      # Examples:
      #    Honeybadger::Read::Deploy.find(project_id, deploy_id)
      #
      def self.find(project_id, deploy_id)
        path = "projects/#{project_id}/deploys/#{deploy_id}"
        Honeybadger::Read::Request.find(path, handler)
      end

      def self.handler
        Proc.new { |response| Deploy.new(response) }
      end
    end
  end
end