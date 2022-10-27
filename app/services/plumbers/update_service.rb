module Plumbers
  class UpdateService < BaseService

    def initialize(id, attributes)
      @plumber = Plumber.find(id)
      @attributes = attributes
    end

    def execute
      plumber.update!(attributes)

      plumber.reload
    end

    private

    attr_reader :plumber, :attributes

  end
end
