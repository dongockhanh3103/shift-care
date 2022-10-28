# frozen_string_literal: true

require 'rails_helper'

describe Admin::V1::AuthenticationsController.name, type: :request do
  context 'when get login successfully' do
    it 'with valid email and password' do
      user = User.create!(email: 'sample@example.com', name: 'admin', password: 'admin@123', password_confirmation: 'admin@123', role: :admin)
      params = { email: user.email, password: 'admin@123' }
      headers = { ACCEPT: :'application/json' }
      post '/admin/v1/authentications', params: params, headers: headers

      body_json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body_json['status']).to eq('success')
      expect(body_json['data']['info']['email']).to eq(user.email)
      expect(body_json['data']['info']['access_token']).to be_present
    end
  end

  context 'when get login failure' do
    it 'with invalid password' do
      params = { email: 'admin@example.com', password: 'dummy' }
      headers = { ACCEPT: :'application/json' }
      post '/admin/v1/authentications', params: params, headers: headers

      body_json = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body_json['status']).to eq('failed')
    end
  end

  context 'when logout' do
    it 'return success with valid access_token' do
      password = 'admin@123'
      user = User.create!(email: 'sample@example.com', name: 'admin', password: password, password_confirmation: password, role: :admin)
      logged_in = Authn::Authentication.login(user.email, password)
      access_token = logged_in[:info][:access_token]
      refresh_token = RefreshToken.where(user_id: user.id, crypted_token: access_token).first

      expect(logged_in[:success]).to eq(true)
      expect(refresh_token).to be_present
      final_access_token = "Bearer #{access_token}"
      headers = { ACCEPT: :'application/json', AUTHORIZATION: final_access_token }

      delete '/admin/v1/authentications', headers: headers

      expect(response.status).to eq(200)
      refresh_token = RefreshToken.where(user_id: user.id, crypted_token: access_token).first
      expect(refresh_token).to be(nil)
    end

    it 'provided, empty access_token should failed' do
      delete '/admin/v1/authentications', headers: @headers_with_no_auth

      expect(response.status).to eq(401)
    end
  end
end
