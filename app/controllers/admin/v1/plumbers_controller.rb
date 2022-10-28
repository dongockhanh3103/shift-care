module Admin
  class V1::PlumbersController < BaseController

    include ActsResource

    def create
      @resource = ::Plumbers::CreateService.execute(permitted_params)

      render :show, formats: :json
    end

    def update
      @resource = ::Plumber::UpdateService.execute(params[:id], permitted_params)

      render :show, formats: :json
    end

    private

    def set_resources_client
      @resource_client ||= Plumber
    end

    def permitted_params
      params.require(:plumbers).permit(
        :name,
        :address,
        vehicles: []
      )
    end

  end
end
