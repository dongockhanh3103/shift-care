json.data do
  json.id @resource.id
  json.type @resource.model_type
  json.attributes @resource.attributes
  json.relationships do
    client = @resource.client
    if client
      json.client do
        json.id client.id
        json.type client.model_type

        json.attributes client.attributes.except('private_note')
      end
    end
  end
end