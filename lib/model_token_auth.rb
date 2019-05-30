require "model_token_auth/railtie"
require 'model_token_auth/access_tokens_config'
require 'model_token_auth/acts_as_model_authenticable'
require 'model_token_auth/acts_as_controller_authenticable'

# => Class associated with the models
# that will be authenticated.
#
# if you want to add functionality or
# parameters you need to open the class
# in the models folder of the rails application
#
class AccessToken < ActiveRecord::Base
  include ModelTokenAuth::AccessTokensConfig
end

# => *
include ModelTokenAuth::ActsAsControllerAuthenticable

# => *
ActiveRecord::Base.include ModelTokenAuth::ActsAsModelAuthenticable
