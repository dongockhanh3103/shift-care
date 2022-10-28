# frozen_string_literal: true

json.data do
  json.partial! 'job', job: @resource
end
