
class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  has_many :account_user_roles

  validates :name, presence: true, uniqueness: true, on: :create
  validates :password, presence: true, confirmation: true, if: :password_changed?

  before_save :digest_password_hash!, if: :password_changed?

  USER_FLAGS_EMAIL_CONFIRMED = 0x01

  scope :all_for_account, lambda {|account|
    joins(:account_user_roles).where('account_user_roles.account_id = ?',account.id)
  }

  def accounts
    Account.all_for_user(self)
  end

  def is_email_confirmed?
    if self.flags & USER_FLAGS_EMAIL_CONFIRMED == 0 then false else true end
  end

  def is_email_confirmed=(value)
    self.flags &= ~USER_FLAGS_EMAIL_CONFIRMED unless value
    self.flags |= USER_FLAGS_EMAIL_CONFIRMED if value
  end

  def is_password_match?(pwd)
    digest_password_hash! unless @password.nil?
    self.password_hash == get_ha1(pwd)
  end

  def self.user_lookup(username)
    self.where(name: username).limit(1).first
  end

  def self.email_lookup(email)
    self.where(email: email).limit(1).first
  end

  def self.http_digest_ha1(name, pwd)
    ::ActionController::HttpAuthentication::Digest.ha1(
      {
        username: name,
        realm: ::AccountUsers.http_digest_realm
      },
      pwd)
  end

  def password=(value)
    attribute_will_change!('password') if @password != value
    @password = value
  end

  def password_changed?
    changed.include?('password')
  end

  private

  def get_ha1(pwd)
    self.class.http_digest_ha1(self.name, pwd)
  end

  def digest_password_hash!
    self.password_hash = get_ha1(@password)
  end

end
