# frozen_string_literal: true

json.id job.id
json.type job.model_type
json.attributes job.attributes
json.relationships do
  json.client do
    json.partial! 'admin/v1/clients/client', client: job.client
  end

  json.plumbers do
    json.partial! 'admin/v1/plumbers/plumber', collection: job.plumbers, as: :plumber
  end
end
