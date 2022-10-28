# frozen_string_literal: true

require 'rails_helper'

describe Admin::V1::JobsController.name, type: :request do
  let!(:jobs) { create_list(:job, 5) }

  context 'Unauthenticated, should failed' do
    it 'return error' do
      get '/admin/v1/jobs', headers: @headers_with_no_auth

      expect(response).to have_http_status(401)
    end
  end

  context 'when get list jobs successfully' do
    it 'return list jobs' do
      get '/admin/v1/jobs', headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data'].size).to eq(5)
    end
  end

  context 'when get client successfully' do
    let(:job) { create(:job) }

    it 'with existing client' do
      get "/admin/v1/jobs/#{job.id}", headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data']['attributes']['state']).to eq(job.state)
      expect(body['data']['attributes']['client_id']).to eq(job.client_id)
    end
  end

  context 'when create job' do
    let!(:client) { create(:client) }
    let!(:plumber) { create(:plumber) }
    let(:params) do
      {
        jobs: {
          client_id:  client.id,
          entry_time: Time.current
        }
      }
    end

    let(:assigned_params) do
      {
        jobs: {
          client_id:   client.id,
          entry_time:  Time.current,
          plumber_ids: [plumber.id]
        }
      }
    end

    it 'will create open job successfully' do
      post '/admin/v1/jobs', params: params, headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data']['attributes']['state']).to eq('open')
      expect(body['data']['attributes']['client_id']).to eq(client.id)
      expect(body['data']['relationships']['plumbers']).to eq([])
    end

    it 'will create job with assigned plumber' do
      post '/admin/v1/jobs', params: assigned_params, headers: @headers

      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)

      expect(body['data']['attributes']['state']).to eq('assigned')
      expect(body['data']['attributes']['client_id']).to eq(client.id)
      plumber_response = body['data']['relationships']['plumbers'].first

      expect(plumber_response['attributes']['name']).to eq(plumber.name)
    end
  end

  context 'when update job' do
    let!(:client) { create(:client) }
    let!(:plumber) { create(:plumber) }
    let!(:job) { create(:job, client: client) }
    let!(:other_client) { create(:client) }

    let(:params) do
      {
        jobs: {
          client_id:   other_client.id,
          entry_time:  Time.current + 5.days,
          plumber_ids: [plumber.id]
        }
      }
    end

    it 'update job successfully' do
      expect(job.state).to eq('open')
      put "/admin/v1/jobs/#{job.id}", params: params, headers: @headers

      expect(response).to have_http_status(200)

      body = JSON.parse(response.body)
      expect(body['data']['attributes']['state']).to eq('assigned')
      expect(body['data']['attributes']['client_id']).to eq(other_client.id)
    end
  end
end
