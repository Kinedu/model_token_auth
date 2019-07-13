module ModelTokenAuth
  module AccessTokensConfig
    extend ActiveSupport::Concern

    included do
      # => callbacks
      after_initialize :assign_token, if: :new_record?

      # => associations
      belongs_to :entity, polymorphic: true, optional: true

      # => validations
      validates_presence_of :token
      validates_uniqueness_of :token, scope: :entity_type, if: :entity_type?
    end

    private

    def assign_token
      5.times.each do
        send(:token=, SecureRandom.hex(16))

        return true unless self.class.find_by_token(token)
      end
    end
  end
end