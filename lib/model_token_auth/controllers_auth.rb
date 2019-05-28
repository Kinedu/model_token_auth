module ModelTokenAuth
  module ControllersAuth
    def authenticate!
      token = request.headers['HTTP_X_AUTH_TOKEN']

      if token.present?
        token_ = AccessToken.find_by_token(token.split.last)

        if token_&.entity_type?
          authenticate_entity(token_)
        else
          head :unauthorized
        end
      else
        head :bad_request
      end
    end

    private

    def authenticate_entity(token)
      return false if token.entity_type.nil?
      entity = token.entity_type.tableize.singularize

      self.class.send(:attr_reader, "current_#{entity}")
      instance_variable_set("@current_#{entity}", token.entity)
    end
  end
end