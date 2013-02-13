require 'devise/models/session_authenticatable'

module Devise
  module Models
    module SessionAuthenticatable
      extend ActiveSupport::Concern

      def valid_for_authentication?
        true
      end

      # Hook called after session authentication.
      def after_session_authentication
      end

      module ClassMethods
        def find_for_session_authentication(conditions)
          begin
            user = User.where(email: conditions[:email]).first
          rescue Mongoid::Errors::DocumentNotFound
            nil
          end
        end
      end
    end
  end
end
