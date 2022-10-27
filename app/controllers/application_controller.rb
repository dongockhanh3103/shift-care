class ApplicationController < ActionController::API

  include ExceptionRescue

  # Render success response
  def render_success_response(options = { })
    render json: {
      status: 'success'
    }.merge!(options)
  end

  # Render failed response
  def render_failed_response(options = { })
    render json: {
      status: 'failed'
    }.merge!(options)
  end

  # Render 403 error with the details
  def render_unauthorized_errors(exception)
    render json: {
      message: 'Unauthorized.',
      details: exception.error_codes
    }, status: 403
  end

end
