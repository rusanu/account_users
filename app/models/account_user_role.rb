class AccountUserRole < ActiveRecord::Base
  belongs_to :account
  belongs_to :user

  ACCOUNT_RELATION_ACCESS = 0x01
  ACCOUNT_RELATION_ADMIN = 0x02

  ACCOUNT_ROLE_FLAGS_PRIMARY = 0x01

  ACCOUNT_ROLE_STATUS_ACTIVE = 0x01

  DEFAULT_ACCOUNT_RELATION = ACCOUNT_RELATION_ACCESS | ACCOUNT_RELATION_ACCESS
  DEFAULT_ACCOUNT_ROLE_FLAGS = ACCOUNT_ROLE_FLAGS_PRIMARY
  DEFAULT_ACCOUNT_ROLE_STATUS = ACCOUNT_ROLE_STATUS_ACTIVE


  def self.find_user_default_role(user)
    self.where(user: user)\
      .where('relation & ? > 0', ACCOUNT_RELATION_ACCESS | ACCOUNT_RELATION_ADMIN)\
      .where('status & ? > 0', ACCOUNT_ROLE_STATUS_ACTIVE)\
      .order("flags & #{ACCOUNT_ROLE_FLAGS_PRIMARY} DESC")\
      .limit(1).first()
  end
end