# frozen_string_literal: true

Rails.application.routes.draw do
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end
  draw(:api_v1)
  draw(:admin)

  root 'dashboards#index'
  get '*path', to: 'dashboards#index'
end