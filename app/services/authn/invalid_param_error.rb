# frozen_string_literal: true

module Authn
  class InvalidParamError < StandardError

    attr_reader :error_details

    # @param [Object] param object
    # @param [Hash] error_details
    def initialize(param, error_details)
      @error_details = error_details

      super("#{param} invalid, error: #{error_details}")
    end

  end
end
