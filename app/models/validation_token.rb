require 'securerandom'
require 'base64'

class ValidationToken < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  TOKEN_CATEGORY_EMAIL_CONFIRMATION = 1
  TOKEN_CATEGORY_PASSWORD_RESET = 2
  TOKEN_CATEGORY_INVITATION = 3

  def self.find_token(token)
    begin
      self.where(token: Base64.urlsafe_decode64(token)).first
    rescue Exception => e
      Rails.logger.error "ValidationToken.find_token: #{e.class} #{e.message}"
      nil
    end
  end

  def is_reset_password?
    self.category == TOKEN_CATEGORY_PASSWORD_RESET
  end

  def is_confirm_email?
    self.category == TOKEN_CATEGORY_EMAIL_CONFIRMATION
  end

  def is_invitation?
    self.category == TOKEN_CATEGORY_INVITATION
  end

  def to_param
    token_base64
  end

  def token_base64
    Base64.urlsafe_encode64(self.token)
  end

  def url
    AccountUsers::Engine.routes.url_helpers.validation_token_url(self)
  end

  def self.confirm_email(user)
    token = SecureRandom.hex AccountUsers.validation_token_size
    self.create(user: user, 
      category: TOKEN_CATEGORY_EMAIL_CONFIRMATION,
      token: token)
  end

  def self.reset_password(user)
    token = SecureRandom.hex AccountUsers.validation_token_size
    self.create(user: user, 
      category: TOKEN_CATEGORY_PASSWORD_RESET,
      token: token)
  end

end
