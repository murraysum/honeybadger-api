module Honeybadger
  module Read
    class Notice

      attr_reader :id, :fault_id, :environment, :message, :request, :created_at

      def initialize(opts)
        @id = opts[:id]
        @fault_id = opts[:fault_id]
        @environment = opts[:environment]
        @message = opts[:message]
        @request = opts[:request]
        @created_at = opts[:created_at].nil? ? nil : DateTime.parse(opts[:created_at])
      end

      def self.all(project_id, fault_id)
        response = Honeybadger::Read.client.get("projects/#{project_id}/faults/#{fault_id}/notices")
        Honeybadger::Read::Response.new(self, response)
      end

      def self.find(project_id, fault_id, notice_id)
        instance = Honeybadger::Read.client.get("projects/#{project_id}/faults/#{fault_id}/notices/#{notice_id}")
        Notice.new(instance)
      end
    end
  end
end