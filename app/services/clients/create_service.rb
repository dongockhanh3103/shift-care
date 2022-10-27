module Clients
  class CreateService < BaseService

    def initialize(attributes)
      @attributes = attributes
    end

    def execute
      Client.create!(attributes)
    end

    private

    attr_reader :attributes

  end
end
