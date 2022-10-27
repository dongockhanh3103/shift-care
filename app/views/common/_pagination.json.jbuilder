# frozen_string_literal: true

json.paging do
  json.total paging[:total_pages]
  json.number paging[:page]
  json.size paging[:per_page]
end
