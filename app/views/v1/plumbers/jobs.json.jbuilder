json.data do
  json.partial! 'v1/plumbers/job', collection: @resources, as: :job
end

json.partial! 'common/pagination', paging: @paginate if @paginate.present?
