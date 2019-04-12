require 'model_token_auth/token_generator'

module ModelTokenAuth
  module ActsAsModelAuthenticable
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_model_authenticable
        include ModelTokenAuth::TokenGenerator
      end
    end
  end
end