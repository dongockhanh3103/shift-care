# frozen_string_literal: true

module JsonApiRenderer

  def render_jsonapi_error(object, http_status: 422)
    errors = object.respond_to?(:errors) ? object.errors : object
    errors = format_active_model_errors(errors, object.class.name)
    render json: { errors: errors }, status: http_status
  end

  private

  def format_active_model_errors(errors, object_name, http_status: 422)
    return errors unless errors.is_a? ActiveModel::Errors

    errors.map do |error_key, error_message|
      {
        title:  error_message,
        detail: error_message,
        code:   "#{object_name}##{error_key}",
        source: {
          pointer: "#{controller_path}/#{action_name}"
        },
        status: http_status
      }
    end
  end

end
