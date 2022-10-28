# frozen_string_literal: true

json.data do
  json.partial! 'admin/v1/plumbers/plumber', collection: @resources, as: :plumber
end

json.partial! 'common/pagination', paging: @paginate if @paginate.present?
