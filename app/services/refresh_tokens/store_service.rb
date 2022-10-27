# frozen_string_literal: true

module RefreshTokens
  class StoreService < BaseService

    # @param user_id [Integer]      The user's id
    def initialize(user_id, token: nil, refresh_token: nil)
      @user_id = user_id
      @refresh_token = refresh_token
      @token = token
    end

    # Create a new refresh token to map the refresh_token of idp
    # If already existing, update new refresh_token of idp
    #
    # @return [RefreshToken]
    def execute
      return if @user_id.blank?

      @token.nil? ? create_refresh_token : update_refresh_token
    end

    private

    def update_refresh_token
      result = RefreshToken.where(token: @token, user_id: @user_id).first

      result.update!(crypted_token: @refresh_token) if result.present?

      result
    end

    def create_refresh_token
      uniq_token = generate_unique_token

      refresh_token_model = RefreshToken.create!(
                            token:         uniq_token,
                            crypted_token: AuthenTokenService.encode(
                              token:   uniq_token,
                              user_id: @user_id
                            ),
                            user_id:       @user_id
                          )

      refresh_token_model&.crypted_token
    end

    def generate_unique_token
      SecureRandom.uuid
    end

  end
end
