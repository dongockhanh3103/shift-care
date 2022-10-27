# frozen_string_literal: true

require 'rails_helper'

describe V1::JobsController.name, type: :request do
  let!(:client) { create(:client) }
  let!(:plumber) { create(:plumber) }
  let!(:job) { create(:job, client: client) }
  let!(:plumber_job) { create(:plumber_job, job: job, plumber: plumber) }

  context 'when start job' do
    it 'will change state to in_progress' do
      job.assigned!

      put "/v1/jobs/#{job.id}/start"

      job.reload

      expect(response).to have_http_status(:success)
      expect(job.state).to eq('in_progress')
      expect(job.start_at).to be_present
    end
  end

  context 'when make job done' do
    it 'will change state to in_progress' do
      job.assigned!
      job.in_progress!

      put "/v1/jobs/#{job.id}/done"

      job.reload

      expect(response).to have_http_status(:success)
      expect(job.state).to eq('done')
      expect(job.finish_at).to be_present
    end
  end
end