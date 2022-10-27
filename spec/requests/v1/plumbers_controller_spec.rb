# frozen_string_literal: true

require 'rails_helper'

describe V1::PlumbersController.name, type: :request do
  let!(:plumber) { create(:plumber) }
  let!(:other_plumber) { create(:plumber) }

  context 'Get list assigned jobs belongs to a plumber' do
    it 'return empty if jobs did not assign to plumber' do
      get "/v1/plumbers/#{other_plumber.id}/jobs"

      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)

      expect(body['data']).to eq([])
    end

    it 'return list assigned jobs to plumber' do
      5.times.each do
        client = create(:client)

        Jobs::CreateService.execute(
          client_id: client.id,
          plumber_ids: [plumber.id],
          entry_time: Time.current
        )
      end

      get "/v1/plumbers/#{plumber.id}/jobs"
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)

      expect(body['data'].count).to eq(5)
    end

    it 'return list jobs between time period' do
      10.times.each do
        client = create(:client)

        Jobs::CreateService.execute(
          client_id: client.id,
          plumber_ids: [plumber.id],
          entry_time: Time.current + 5.days
        )
      end

      5.times.each do
        client = create(:client)

        Jobs::CreateService.execute(
          client_id: client.id,
          plumber_ids: [plumber.id],
          entry_time: Time.current - 5.days
        )
      end
      filter_params = {
        filters: {
          from_time: Time.current - 1.day,
          to_time: Time.current + 10.days
        }
      }
      get "/v1/plumbers/#{plumber.id}/jobs", params: filter_params
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)

      expect(body['data'].count).to eq(10)
    end

    it 'return empty jobs not between time period' do
      5.times.each do
        client = create(:client)

        Jobs::CreateService.execute(
          client_id: client.id,
          plumber_ids: [plumber.id],
          entry_time: Time.current - 5.days
        )
      end

      filter_params = {
        filters: {
          from_time: Time.current + 1.day,
          to_time: Time.current + 10.days
        }
      }

      get "/v1/plumbers/#{plumber.id}/jobs", params: filter_params
      expect(response).to have_http_status(:success)
      body = JSON.parse(response.body)

      expect(body['data'].count).to eq(0)
    end
  end
end