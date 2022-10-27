# frozen_string_literal: true

module LoginConcern

  extend ActiveSupport::Concern

  # @param email [String]
  # @param password [String]
  def login(email, password)
    response = Authn::Authentication.login(email, password)

    if response[:success]
      render_success_response(data: response)
    else
      render_failed_response
    end
  end

  # Revoke all refresh token and reset session
  def logout
    RefreshTokens::RevokeService.execute(current_user.id)

    # rubocop:disable Lint/UselessAssignment
    current_user = nil
    # rubocop:enable Lint/UselessAssignment
    reset_session

    { success: true }
  end

end
