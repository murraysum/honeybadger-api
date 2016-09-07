module Honeybadger
  module Api
    class Fault

      attr_reader :id, :project_id, :klass, :action, :component, :message,
        :environment, :notices_count, :comments_count, :last_notice_at, :created_at,
        :url, :assignee, :tags, :deploy

      # Public: Build a new instance of Fault
      #
      # opts - A Hash of attributes to initialize a Fault
      #
      # Returns a new Fault
      def initialize(opts)
        @id = opts[:id]
        @project_id = opts[:project_id]
        @klass = opts[:klass]
        @action = opts[:action]
        @component = opts[:component]
        @message = opts[:message]
        @environment = opts[:environment]
        @ignored = opts[:ignored]
        @resolved = opts[:resolved]
        @notices_count = opts[:notices_count]
        @comments_count = opts[:comments_count]
        @last_notice_at = opts[:last_notice_at].nil? ? nil : DateTime.parse(opts[:last_notice_at])
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
        @url = opts[:url]
        if opts[:assignee]
          @assignee = User.new(opts[:assignee][:name], opts[:assignee][:email])
        end
        @tags = opts[:tags]
        @deploy = Deploy.new(opts[:deploy]) unless opts[:deploy].nil?
      end

      # Public: Whether tha fault has been marked as ignored.
      def ignored?
        @ignored == true
      end

      # Public: Whether tha fault has been marked as resolved.
      def resolved?
        @resolved == true
      end

      # Public: A hash comprised of all instance methods.
      def to_h
        {
          :action => action,
          :comments_count => comments_count,
          :component => component,
          :created_at => created_at,
          :deploy_revision => deploy.revision,
          :environment => environment,
          :error_class => klass,
          :error_message => message,
          :id => id,
          :ignored => ignored?,
          :last_notice_at => last_notice_at,
          :notices_count => notices_count,
          :project_id => project_id,
          :resolved => resolved?,
          :tags => tags,
          :url => url
        }
      end

      # Public: Find all faults for a given project.
      def self.all(project_id)
        path  = "projects/#{project_id}/faults"
        Honeybadger::Api::Request.all(path, handler)
      end

      # Public: Paginate all faults for a given project.
      def self.paginate(project_id, filters = {})
        path  = "projects/#{project_id}/faults"
        Honeybadger::Api::Request.paginate(path, handler, filters)
      end

      # Public: Find a fault for a given project.
      def self.find(project_id, fault_id)
        path = "projects/#{project_id}/faults/#{fault_id}"
        Honeybadger::Api::Request.find(path, handler)
      end

      # Internal: The handler used to build objects from API responses.
      def self.handler
        Proc.new { |response| Fault.new(response) }
      end
    end
  end
end
