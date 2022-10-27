# frozen_string_literal: true

json.id job.id
json.type job.model_type
json.attributes job.attributes
json.relationships do
  json.client do
    client = job.client
    json.id client.id
    json.type client.model_type
    json.attributes client.attributes.except('private_note')
  end
end
