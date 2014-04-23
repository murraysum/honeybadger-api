module Honeybadger
  module Read
    class Notice

      attr_reader :id, :fault_id, :environment, :message, :request, :created_at

      def initialize(opts)
        @id = opts[:id]
        @fault_id = opts[:fault_id]
        @environment = Environment.new(opts[:environment])
        @message = opts[:message]
        @request = opts[:request]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      def self.all(project_id, fault_id)
        path = "projects/#{project_id}/faults/#{fault_id}/notices"
        response = Honeybadger::Read.client.get(path)
        Honeybadger::Read::Paginator.new(self, path, response)
      end

      def self.find(project_id, fault_id, notice_id)
        Honeybadger::Read::Request.perform do |request|
          request.path "projects/#{project_id}/faults/#{fault_id}/notices/#{notice_id}"
          request.handler { |response| Notice.new(response) }
        end
      end
    end
  end
end