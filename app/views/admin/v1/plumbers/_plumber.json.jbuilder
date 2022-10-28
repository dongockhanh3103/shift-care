# frozen_string_literal: true

json.id plumber.id
json.type plumber.model_type
json.attributes plumber.attributes
json.relationships do
  json.vehicles do
    json.partial! 'admin/v1/vehicles/vehicle', collection: plumber.vehicles, as: :vehicle
  end
end
