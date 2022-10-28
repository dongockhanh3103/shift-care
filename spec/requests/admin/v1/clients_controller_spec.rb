# frozen_string_literal: true

require 'rails_helper'

describe Admin::V1::ClientsController.name, type: :request do
  let!(:clients) { create_list(:client, 5) }

  context 'Unauthenticated, should failed' do
    it 'return error' do
      get '/admin/v1/clients', headers: @headers_with_no_auth

      expect(response).to have_http_status(401)
    end
  end

  context 'when get list clients successfully' do
    it 'with existing clients' do
      get '/admin/v1/clients', headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data'].size).to eq(5)
    end
  end

  context 'when get client successfully' do
    let(:client) { create(:client) }

    it 'with existing client' do
      get "/admin/v1/clients/#{client.id}", headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data']['attributes']['name']).to eq(client.name)
      expect(body['data']['attributes']['age']).to eq(client.age)
      expect(body['data']['attributes']['address']).to eq(client.address)
      expect(body['data']['attributes']['private_note']).to eq(client.private_note)
    end
  end

  context 'when create client' do
    let(:params) do
      {
        clients: {
          name: Faker::Name.unique.name,
          age: 18,
          address: Faker::Address.full_address,
          private_note: Faker::Lorem.sentence
        }
      }
    end

    let(:invalid_params) do
      {
        clients: {
          age: 18,
          address: Faker::Address.full_address,
          private_note: Faker::Lorem.sentence
        }
      }
    end

    it 'will create client successfully' do
      post '/admin/v1/clients', params: params, headers: @headers

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(body['data']['attributes']['name']).to eq(params[:clients][:name])
      expect(body['data']['attributes']['age']).to eq(params[:clients][:age])
      expect(body['data']['attributes']['address']).to eq(params[:clients][:address])
      expect(body['data']['attributes']['private_note']).to eq(params[:clients][:private_note])
    end

    it 'will create client failure' do
      post '/admin/v1/clients', params: invalid_params, headers: @headers

      expect(response).to have_http_status(422)
    end
  end
end
