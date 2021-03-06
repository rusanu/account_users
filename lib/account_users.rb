require 'account_users/version'
require 'active_model/model_invalid_error'
require 'account_users/action_controller_concern.rb'
require 'account_users/active_model_concern'
require 'account_users/engine'

module AccountUsers
  class << self
    mattr_accessor :http_digest_realm
    mattr_accessor :terms_of_service_path
    mattr_accessor :login_user
    mattr_accessor :logout_user
    mattr_accessor :login_success_redirect_path
    mattr_accessor :logout_redirect_path
    mattr_accessor :account_provision
    mattr_accessor :validation_token_size

    self.validation_token_size = 20

    self.account_provision = lambda{|account, user|
      AccountMailer.welcome_email(account, user).deliver_now
      UserMailer.confirm_email(user).deliver_now
    }

    def login_user(&block)
      @@__login_user_block = block
    end

    def call_login_user(session, user)
      role = AccountUserRole.find_user_default_role user
      account = role.account
      @@__login_user_block.call(session, account, user, role) unless @@__login_user_block.nil?
      account
    end

    def logout_user(&block)
      @@__logout_user_block = block
    end

    def call_logout_user(session)
      @@__logout_user_block.call(session) unless @@__logout_user_block.nil?
    end

    def is_already_logged_in?(&block)
      @@__is_already_logged_in_block = block
    end

    def call_is_already_logged_in?(session)
      @@__is_already_logged_in_block.call(session) unless @@__is_already_logged_in_block.nil?
    end

    def lookup_user_for_http_digest(user_name)
      user = User.where(name: user_name).first
      user.nil? ? nil : user.password_hash
    end

  end

  def self.setup(&block)
    yield self
  end

end
