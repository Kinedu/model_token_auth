require "model_token_auth/railtie"
require 'model_token_auth/access_tokens_config'
require 'model_token_auth/acts_as_model_authenticable'
require 'model_token_auth/acts_as_controllers_authenticable'

module ModelTokenAuth; end

class AccessToken < ActiveRecord::Base
  include ModelTokenAuth::AccessTokensConfig
end

ActiveRecord::Base.include(ModelTokenAuth::ActsAsModelAuthenticable)

ActionController::Base.include(
  ModelTokenAuth::ActsAsControllersAuthenticable
) if ActionController::Base

ActionController::API.include(
  ModelTokenAuth::ActsAsControllersAuthenticable
) if ActionController::API