# frozen_string_literal: true

Rails.application.routes.draw do
  api_version(
    module: 'Admin', path: { value: 'admin' },
    defaults: { format: :json }
  ) do
    resource :authentications, only: [:create, :destroy] do
      post :refresh_token
    end

    resources :plumbers do
      get :jobs, on: :member
    end

    resources :jobs, only: [:create, :index, :show, :update]
    resources :vehicles
    resources :clients
  end
end