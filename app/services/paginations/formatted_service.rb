# frozen_string_literal: true

module Paginations
  class FormattedService < BaseService

    attr_reader :queried_data, :page, :per_page

    DEFAULT_PAGE = 1
    DEFAULT_LIMIT = 20

    def initialize(queried_data:, page: nil, per_page: nil)
      @queried_data = queried_data.paginate(page: page, per_page: per_page)
      @page = page.presence || DEFAULT_PAGE
      @per_page = per_page.presence || DEFAULT_LIMIT
    end

    def execute
      {
        data:   queried_data,
        paging: {
          total_pages: queried_data.total_pages,
          page:        page,
          per_page:    per_page
        }
      }
    end

  end
end
