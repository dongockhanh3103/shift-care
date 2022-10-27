# frozen_string_literal: true

module Admin
  class JobsController < BaseController

    include ActsResource

    def create
      @resource = Jobs::CreateService.execute(permitted_params)

      render :show, formats: :json
    end

    def update
      @resource = Jobs::UpdateService.execute(params[:id], permitted_params)

      render :show, formats: :json
    end

    private

    def permitted_params
      params.require(:jobs).permit(
        :client_id,
        :entry_time,
        plumber_ids: []
      )
    end

    def set_resources_client
      @resource_client ||= Job
    end

    def includes_attributes
      %i[plumbers client]
    end

  end
end
