require 'model_token_auth/controllers_auth'

module ModelTokenAuth
  module ActsAsControllerAuthenticable
    def acts_as_controller_authenticable
      include ModelTokenAuth::ControllersAuth
    end
  end
end