# frozen_string_literal: true

json.data do
  json.partial! 'admin/clients/client', collection: @resources, as: :client
end

json.partial! 'common/pagination', paging: @paginate if @paginate.present?
