# frozen_string_literal: true

module Authn
  class UnauthenticatedError < StandardError

    attr_reader :error_codes

    # @param [Array] error_codes details error that cause unauthenticated error
    def initialize(error_codes = [])
      super
      @error_codes = error_codes
    end

  end
end
