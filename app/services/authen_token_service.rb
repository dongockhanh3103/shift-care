# frozen_string_literal: true

module AuthenTokenService

  SIGNED_ALGORITHM = 'HS256'

  # Encode data with a secret key by using HMAC SHA256 algorithm to
  # create a token for user login section
  #
  # @param payload [Object] Contains statements about an entity (typically, the user)
  #                         and additional metadata
  #
  # @return [String] The base64 encoded string
  def self.encode(payload, exp: false)
    payload[:exp] = 24.hours.from_now.to_i if exp

    JWT.encode(payload, hmac_secret, SIGNED_ALGORITHM)
  end

  # @param token [String] a jwt token
  #
  # @return [Hash] decoded payload
  def self.decode(token)
    decoded_info = JWT.decode(token, nil, false).first
    decoded_info.present? ? decoded_info.with_indifferent_access : { }
  end

  # Set secret key for JWT service
  def self.hmac_secret
    @jwt_config ||= YAML.load_file(File.join(Rails.root, 'config', 'jwt.yml'))

    @jwt_config[Rails.env]['hmac_secret']
  end

  private_class_method :hmac_secret

end
