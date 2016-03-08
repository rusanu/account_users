module AccountUsers
  module ActionControllerConcern
    extend ActiveSupport::Concern

    module ClassMethods
      def account_users_require_http_digest
        self.class_eval do
          prepend_before_action :account_users_http_digest_filter

          private
          
          def account_users_http_digest_filter
            if AccountUsers.call_is_already_logged_in?(session)
              return true
            end
            AccountUsers.call_logout_user session
            user_name_used = nil
            success = authenticate_or_request_with_http_digest  AccountUsers::http_digest_realm do |username|
              user_name_used = username
              AccountUsers.lookup_user_for_http_digest username
            end
            if (success == true)
              user = User.where(name: user_name_used).first
              AccountUsers.call_login_user session, user
            end

            return success
          end

        end
      end
    end
  end
end
