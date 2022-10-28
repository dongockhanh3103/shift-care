# frozen_string_literal: true

Rails.application.routes.draw do
  api_version(
    module: 'V1', path: { value: 'v1' },
    defaults: { format: :json }
  ) do
    resources :jobs, only: [:index, :show] do
      member do
        put :start
        put :done
      end
    end

    resources :plumbers, only: :index do
      get :jobs, on: :member
    end
  end
end