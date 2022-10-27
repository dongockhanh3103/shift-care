# frozen_string_literal: true

module Authn
  class Authentication

    class << self

      # This uses to check email and password of user is correct or not, user is existing or not.
      # Then create token to authenticated user to use services of system.
      #
      #
      # @param email    [String] User email
      # @param password [String] User password
      #
      # @return [String] Token to mark that user is authenticated
      def login(email, password)
        user = User.find_by_email(email)

        return { success: false } if user.nil?
        return { success: false } unless user.valid_password?(password)

        access_token = RefreshTokens::StoreService.execute(user.id)

        {
          success: true,
          info:    {
            email:        user.email,
            name:         user.name,
            role:         user.role,
            access_token: access_token
          }
        }
      end

      # Refresh token
      def refresh_token(refresh_token_params)
        user = User.find_by_id(refresh_token_params[:user_id])
        refresh_token_model = RefreshToken.where(
          user_id: user.id,
          token:   refresh_token_params[:token]
        ).first

        return { success: false } if refresh_token_model.blank?

        refresh_token_encoded = AuthenTokenService.encode(
                                  user_id: user.id,
                                  token:   refresh_token_params[:token]
                                )
        access_token = AuthenTokenService.encode({ email: user.email }, exp: true)
        RefreshTokens::StoreService.execute(
          user.id,
          token:         refresh_token_params[:token],
          refresh_token: refresh_token_encoded
        )

        { success: true, refresh_token: refresh_token_encoded, token: access_token }
      end

    end

  end
end
