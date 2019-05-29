module ModelTokenAuthHelper
  def skip_authentication!(access_token)
    subject.class.skip_before_action(:authenticate!, raise: false)
    subject.send(:authenticate_entity, access_token)
  end

  def add_authorization_header!(token)
    request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Token.encode_credentials(token)
  end
end