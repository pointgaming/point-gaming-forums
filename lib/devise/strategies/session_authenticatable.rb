require 'devise/strategies/base'

module Devise
  module Strategies
    class SessionAuthenticatable < Authenticatable
      def store?
        super && !mapping.to.skip_session_storage.include?(:session_auth)
      end

      def authenticate!
        resource = mapping.to.find_for_session_authentication(authentication_hash)
        return fail(:invalid_session) unless resource

        if validate(resource)
          resource.after_session_authentication
          success!(resource)
        end
      end

    private

      # Session Authenticatable can be authenticated with session in any controller and any verb.
      def valid_params_request?
        session.has_key?(authentication_keys.first)
      end

      # Do not use remember_me behavior
      def remember_me?
        false
      end

      # Try both scoped and non scoped keys.
      def params_auth_hash
        if session[scope].kind_of?(Hash) && session[scope].has_key?(authentication_keys.first)
          session[scope]
        else
          session
        end
      end

      def authentication_keys
        [:email]
      end
    end
  end
end

Warden::Strategies.add(:session_authenticatable, Devise::Strategies::SessionAuthenticatable)
