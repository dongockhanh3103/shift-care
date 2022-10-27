# frozen_string_literal: true

module V1
  class JobsController < ApplicationController

    before_action :find_job

    def start
      @resource.in_progress!

      render :show, formats: :json
    end

    def done
      @resource.done!

      render :show, formats: :json
    end

    def show; end

    private

    def find_job
      @resource ||= Job.find(params[:id])
    end

  end
end
