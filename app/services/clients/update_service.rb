module Clients
  class UpdateService < BaseService

    def initialize(id, attributes)
      @client = Client.find(id)
      @attributes = attributes
    end

    def execute
      client.update!(attributes)

      client.reload
    end

    private

    attr_reader :attributes, :client

  end
end
