module ModelTokenAuth
  module ControllersAuth
    def authenticate!
      token = request.headers['HTTP_AUTHORIZATION']

      if token.present?
        token_ = AccessToken.find_by_token(parses_the_token(token))

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

    # => *
    def authenticate_entity(token)
      return false if token.entity_type.nil?
      entity = token.entity_type.tableize.singularize

      self.class.send(:attr_reader, "current_#{entity}")
      instance_variable_set("@current_#{entity}", token.entity)
    end

    # => *
    def parses_the_token(token)
      token.split.last.remove('token=').parameterize
    end
  end
end