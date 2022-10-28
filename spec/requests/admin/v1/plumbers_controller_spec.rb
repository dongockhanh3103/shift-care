# frozen_string_literal: true

require 'rails_helper'

describe Admin::V1::PlumbersController.name, type: :request do
  let!(:plumbers) { create_list(:plumber, 5) }

  context 'Unauthenticated, should failed' do
    it 'return error' do
      get '/admin/v1/plumbers', headers: @headers_with_no_auth

      expect(response).to have_http_status(401)
    end
  end

  context 'when get list plumbers successfully' do
    it 'with existing plumbers' do
      get '/admin/v1/plumbers', headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data'].size).to eq(5)
    end
  end

  context 'when get plumber successfully' do
    let(:plumber) { create(:plumber) }

    it 'with existing plumber' do
      get "/admin/v1/plumbers/#{plumber.id}", headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data']['attributes']['name']).to eq(plumber.name)
      expect(body['data']['attributes']['address']).to eq(plumber.address)
    end
  end

  context 'when create plumber' do
    let!(:vehicle) { create(:vehicle) }
    let(:params) do
      {
        plumbers: {
          name: Faker::Name.unique.name,
          address: Faker::Address.full_address,
          vehicles: [vehicle.id]
        }
      }
    end

    let(:invalid_params) do
      {
        plumbers: {
          age: 18,
          address: Faker::Address.full_address
        }
      }
    end

    it 'will create plumber successfully' do
      post '/admin/v1/plumbers', params: params, headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data']['attributes']['name']).to eq(params[:plumbers][:name])
      expect(body['data']['attributes']['address']).to eq(params[:plumbers][:address])
      fetched_vehicle = body['data']['relationships']['vehicles'].first
      expect(fetched_vehicle['attributes']['name']).to eq(vehicle.name)
    end

    it 'will create plumber failure' do
      post '/admin/v1/plumbers', params: invalid_params, headers: @headers

      expect(response).to have_http_status(422)
    end
  end
end
