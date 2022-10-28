# frozen_string_literal: true

module V1
  class JobsController < ApplicationController

    include ActsResource

    def start
      get_resource!
      @resource.in_progress!

      render :show, formats: :json
    end

    def done
      get_resource!
      @resource.done!

      render :show, formats: :json
    end

    private

    def set_resources_client
      @resource_client ||= Job
    end
  end
end
