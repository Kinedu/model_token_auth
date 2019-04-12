require 'model_token_auth/controllers_auth'

module ModelTokenAuth
  module ActsAsControllersAuthenticable
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_controller_authenticable
        include ModelTokenAuth::ControllersAuth
      end
    end
  end
end