module ModelTokenAuth
  module TokenGenerator
    extend ActiveSupport::Concern

    included do
      
      # => callbacks
      before_validation :build_access_token, on: :create

      # => associations
      has_one :access_token, as: :entity

      # => validations
      validates_associated :access_token
    end

    def access_token
      if super.nil?
        raise NoDefinedToken
      else
        super
      end
    end

    class ::NoDefinedToken < Exception
      def message
        'there is not defined token' 
      end
    end
  end
end