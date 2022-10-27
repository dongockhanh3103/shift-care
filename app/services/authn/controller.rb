# frozen_string_literal: true

module Authn

  module Controller

    # Authenticate user through Bearer token
    def self.included(klass)
      klass.class_eval do
        include InstanceMethods
      end
    end

  end

  module InstanceMethods

    # verify the request has beare token
    # get HTTP_AUTHORIZATION header and verify
    def authentication_user!
      raise Authn::UnauthenticatedError if get_bearer_token.nil?

      decoded = AuthenTokenService.decode(get_bearer_token)

      raise Authn::UnauthenticatedError if decoded.blank?

      user = User.find_by(id: decoded[:user_id])

      raise Authn::UnauthenticatedError if user.nil?

      refresh_token = RefreshToken.where(token: decoded[:token], user_id: decoded[:user_id]).first

      raise Authn::UnauthenticatedError if refresh_token.nil?

      login_success(user)
    end

    # attempts to auto-login from the sources defined
    # returns the logged in user if found, nil if not
    def current_user
      @current_user = login_from_session || nil unless defined?(@current_user)
      @current_user
    end

    # Assign current_user
    def current_user=(user)
      @current_user = user
    end

    # Login a user instance
    #
    # @param [User] user the user instance.
    # @return - do not depend on the return value.
    def login_success(user)
      session[:user_email] = user.email
      @current_user = user
    end

    protected

    def login_from_session
      @current_user = (User.find_by_email(session[:user_email]) if session[:user_email])
    end

    # Get Bearer token from authorization token
    #
    # @return [String] The token, return `nil` if no Bearer token
    def get_bearer_token
      token = request.env['HTTP_AUTHORIZATION']

      bearer_pattern = %r{^Bearer }
      token&.match(bearer_pattern) ? token.gsub(bearer_pattern, '') : nil
    end

  end

end
