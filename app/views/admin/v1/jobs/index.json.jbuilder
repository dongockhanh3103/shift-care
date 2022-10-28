# frozen_string_literal: true

json.data do
  json.array! @resources do |job|
    json.id job.id
    json.type job.model_type
    json.attributes job.attributes

    json.relationships do
      json.client do
        json.id job.client.id
        json.name job.client.name
      end

      json.plumbers do
        json.array! job.plumbers do |plumber|
          json.id plumber.id
          json.name plumber.name
        end
      end
    end
  end
end

json.partial! 'common/pagination', paging: @paginate if @paginate.present?