module Jobs
  class UpdateService < BaseService

    def initialize(id, params)
      @job = Job.find(id)
      @params = params
    end

    def execute
      ActiveRecord::Base.transaction do
        job.update!(params.slice(:client_id, :entry_time))
        plumber_ids = params.slice(:plumber_ids)['plumber_ids']

        re_assigned_plumbers(plumber_ids)

        job
      end
    end

    private

    attr_reader :job, :params

    def re_assigned_plumbers(plumber_ids)
      if plumber_ids.present?
        plumber_ids.each do |pi|
          PlumberJob.create!(
            plumber_id: pi,
            job_id:     job.id
          )
        end
  
        job.assigned!
      end
    end

  end
end
