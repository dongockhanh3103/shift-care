# frozen_string_literal: true

module Jobs
  class CreateService < BaseService

    def initialize(params)
      @params = params
    end

    def execute
      ActiveRecord::Base.transaction do
        client = Client.find(params[:client_id])
        job = Job.create!(
          client:     client,
          entry_time: params[:entry_time]
        )

        if params[:plumber_ids].present?
          PlumberJob.insert_all(build_plumber_jobs_attributes(params[:plumber_ids], job.id))
          job.assigned!
        end

        job
      end
    end

    private

    attr_reader :params

    def build_plumber_jobs_attributes(plumber_ids, job_id)
      plumber_ids.map do |plumber_id|
        {
          plumber_id: plumber_id,
          job_id:     job_id,
          created_at: Time.current,
          updated_at: Time.current
        }
      end
    end

  end
end
