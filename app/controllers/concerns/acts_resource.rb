# frozen_string_literal: true

module ActsResource

  extend ActiveSupport::Concern
  SIZE_DEFAULT = 20
  PAGE_NUMBER_DEFAULT = 1

  included do
    before_action :set_resources_client
  end

  def index
    get_resources!

    @paginate = {
      total_pages: @resources.total_pages,
      page:        @resources.current_page,
      per_page:    @resources.per_page
    }
  end

  def show
    get_resource!
  end

  private

  def get_resource!
    @resource_client = @resource_client.includes(*includes_attributes) if includes_attributes.present?
    @resource ||= @resource_client.find(params[:id])
  end

  def get_resources!
    @resources ||= query_with_parser(parse_params)
  end

  def query_with_parser(parse_params = { })
    filters = parse_params.fetch(:filters)
    paginator = parse_params.fetch(:paginator)
    sort_criterias = parse_params.fetch(:sort_criterias)
    query_builder = @resource_client
    query_builder = query_builder.includes(*includes_attributes) if includes_attributes.present?
    query_builder = query_builder.where(filters) if filters.present?
    query_builder = query_builder.order(sort_criterias) if sort_criterias.present?

    if paginator.present?
      query_builder = query_builder.paginate(
        page:     parse_paginator_params[:page],
        per_page: parse_paginator_params[:per_page]
      )
    end

    query_builder.all
  end

  def parse_params
    @parse_params ||= {
      filters:        parse_filters_params,
      paginator:      parse_paginator_params,
      sort_criterias: parse_sorts_params
    }
  end

  def parse_paginator_params
    paginator = jsonapi_get_params[:page] || { }

    per_page = paginator[:size] || SIZE_DEFAULT
    page = paginator[:number] || PAGE_NUMBER_DEFAULT

    OpenStruct.new(
      {
        page:     page,
        per_page: per_page
      }
    )
  end

  def parse_sorts_params
    fields = jsonapi_get_params[:sort].try(:split, ',') || []
    convert_to_ordered_hash(fields)
  end

  def parse_filters_params
    result = { }
    jsonapi_get_params[:filter].to_h.each do |key, value|
      result[key] = value
    end

    result
  end

  def jsonapi_get_params
    @jsonapi_get_params ||= params.except(:format).permit(
      :sort,
      filter: filter_attributes,
      page:   %i[
        size
        number
      ]
    )
  end

  def filter_attributes
    []
  end

  def sort_criteria
    [:id]
  end

  def includes_attributes
    nil
  end

  def set_resources_client
    # rubocop:disable Style/ImplicitRuntimeError
    raise 'Method not implemented'
  end

  def convert_to_ordered_hash(fields)
    fields.each_with_object({ }) do |field, hash|
      direction = :asc
      if field.start_with?('-')
        field = field[1..].to_sym
        direction = :desc
      end
      hash[field] = direction if sort_criteria.include?(field.to_sym)
    end
  end

end
