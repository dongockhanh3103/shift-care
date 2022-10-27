# frozen_string_literal: true

module Admin
  class AuthenticationsController < BaseController

    include LoginConcern

    skip_before_action :authentication_user!, only: %i[create refresh_token]

    def create
      login(login_params[:email], login_params[:password])
    end

    def refresh_token; end

    def destroy
      response = logout

      if response[:success]
        render_success_response
      else
        render_failed_response
      end
    end

    private

    def login_params
      if params[:email].nil? || params[:password].nil?
        raise ::Authn::InvalidParamError.new(params, 'Email or password is invalid')
      end

      params.permit(:email, :password)
    end

  end
end
