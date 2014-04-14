module Honeybadger
  module Read
    class Project

      attr_reader :id, :name, :owner, :users, :token, :environments, :integrations,
        :fault_count, :unresolved_fault_count, :last_notice_at, :created_at

      def initialize(opts)
        @id = opts[:id]
        @name = opts[:name]
        @owner = User.new(opts[:owner][:name], opts[:owner][:email])
        @users = opts[:users].collect { |user| User.new(user[:name], user[:email]) }
        @token = opts[:token]
        @environments = opts[:environments].collect do |env|
          Environment.new(env)
        end
        @active = opts[:active]
        @disable_public_links = opts[:disable_public_links]
        # @integrations = [].tap do |integrations|
        #   integrations.push Integration.new("Github", opts[:github_project])
        #   integrations.push Integration.new("Pivotal", opts[:pivotal_project_id])
        #   integrations.push Integration.new("Asana", opts[:asana_workspace_id])
        # end
        @fault_count = opts[:fault_count]
        @unresolved_fault_count = opts[:unresolved_fault_count]
        @last_notice_at = opts[:last_notice_at].nil? ? nil : DateTime.parse(opts[:last_notice_at])
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      # Public: Whether the project is active.
      def active?
        @active == true
      end

      # Public: Whether the project is inactive.
      def inactive?
        @active == false
      end

      def public_links?
        @disable_public_links == false
      end

      def private_links?
        @disable_public_links == true
      end

      def self.all
        path = "projects"
        response = Honeybadger::Read.client.get(path)
        Honeybadger::Read::Paginator.new(self, path, response)
      end

      def self.find(project_id)
        instance = Honeybadger::Read.client.get("projects/#{project_id}")
        Project.new(instance)
      end
    end
  end
end