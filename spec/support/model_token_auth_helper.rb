module ModelTokenAuthHelper

  # => skip authentication but still creates the
  # instance variable #current_<model-name>.
  #
  def skip_authentication!(access_token)
    subject.class.skip_before_action(:authenticate!, raise: false)
    subject.send(:authenticate_entity, access_token)
  end

  # => add the 'Authorization' header with the
  # value of the token that is passed to it,
  # giving it the necessary format.
  #
  def add_authorization_header(access_token)
    subject.request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Token.encode_credentials(access_token.token)
  end
end