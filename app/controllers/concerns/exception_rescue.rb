# frozen_string_literal: true

module ExceptionRescue

  extend ActiveSupport::Concern
  include JsonApiRenderer

  included do
    rescue_from ActiveRecord::RecordInvalid, ActiveModel::ValidationError, with: :render_unprocessable_entity_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from Authn::UnauthenticatedError, with: :render_unauthenticated_response
    rescue_from Authn::InvalidParamError, with: :render_invalid_param_error_response
    rescue_from ActionController::RoutingError, with: :render_not_found_response
  end

  private

  def render_unprocessable_entity_response(exception)
    render_jsonapi_error(exception.try(:model) || exception.try(:record))
  end

  def render_not_found_response(exception)
    render json: {
      title:  "#{exception.model} not found",
      detail: exception.message,
      code:   "#{exception.model}#id",
      source: {
        pointer: "#{controller_path}/#{action_name}"
      }
    }, status: :not_found
  end

  def render_unauthenticated_response(exception)
    render json: {
      message: 'UnAuthenticated.',
      details: exception.error_codes
    }, status: 401
  end

  def render_invalid_param_error_response(invalid_param_error)
    render json: {
      message: 'Provided params do not valid.',
      details: invalid_param_error.error_details
    }, status: 422
  end

  def render_route_not_found
    render json: {
      message: '404 Not Found',
      details: exception.error_codes
    }, status: 404
  end

end
