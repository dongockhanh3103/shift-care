# frozen_string_literal: true

module V1
  class PlumbersController < ApplicationController

    def jobs
      jobs = Plumbers::GetAssignedJobsService.execute(plumber_id: params[:id], filter_params: filter_params)
      result = Paginations::FormattedService.execute(queried_data: jobs,
                                                     page:         page_params[:page],
                                                     per_page:     page_params[:per_page])
      @resources = result[:data]
      @paginate = result[:paging]
    end

    private

    def filter_params
      params.fetch(:filters, { }).permit(
        :from_time,
        :to_time
      )
    end

    def page_params
      params.fetch(:page, { }).permit(
        :number,
        :size
      )
    end

  end
end
