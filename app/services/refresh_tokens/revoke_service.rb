# frozen_string_literal: true

module RefreshTokens
  class RevokeService < BaseService

    # @param user_id [Integer] The user's id
    def initialize(user_id)
      @user_id = user_id
    end

    # Destroy all Refresh token belongs to user
    #
    # Return [Boolean] can destroy or not
    def execute
      RefreshToken.where(user_id: @user_id).destroy_all
    end

  end
end
