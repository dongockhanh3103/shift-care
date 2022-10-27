# frozen_string_literal: true

module Admin
  class BaseController < ApplicationController

    include ::Authn::Controller

    before_action :authentication_user!

  end
end
