# frozen_string_literal: true

module Admin
  class V1::ClientsController < BaseController

    include ActsResource

    def create
      @resource = ::Clients::CreateService.execute(permitted_params)

      render :show, formats: :json
    end

    def update
      @resource = ::Clients::UpdateService.execute(params[:id], permitted_params)

      render :show, formats: :json
    end

    private

    def set_resources_client
      @resource_client ||= Client
    end

    def permitted_params
      params.require(:clients).permit(
        :name,
        :age,
        :private_note,
        :address
      )
    end

  end
end
