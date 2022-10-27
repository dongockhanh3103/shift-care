# frozen_string_literal: true

module Plumbers
  class GetAssignedJobsService < BaseService

    def initialize(plumber_id:, filter_params:)
      @filter_params = filter_params
      @scope = Job.joins(:plumber_jobs).where(state: :assigned, plumber_jobs: { plumber_id: plumber_id })
    end

    def execute
      by_period

      @scope.order(entry_time: :desc)
    end

    private

    attr_reader :filter_params

    def by_period
      return if filter_params[:from_time].nil? || filter_params[:to_time].nil?

      parsed_from_time = Time.parse(filter_params[:from_time])
      parsed_to_time = Time.parse(filter_params[:to_time])

      if parsed_from_time > parsed_to_time
        raise ::Authn::InvalidParamError.new(params, 'To Time must higher than From Time')
      end

      @scope = @scope.where(entry_time: parsed_from_time..parsed_to_time)
    end

  end
end
