
class SignupPresenter < ActivePresenter::Base
  presents :account, :user, :account_user_role

  def initialize(args={})
    super(args)
    self.user = User.new if self.user.nil?
    self.account = Account.new if self.account.nil?
    self.account_user_role = AccountUserRole.new if self.account_user_role.nil?
    self.account_user_role.user = self.user
    self.account_user_role.account = self.account

    self.user_name = self.user_email if self.user_name.blank?
    self.user_email = self.user_name if self.user_email.blank?

    self.account_user_role.relation = AccountUserRole::DEFAULT_ACCOUNT_RELATION
    self.account_user_role.flags = AccountUserRole::DEFAULT_ACCOUNT_ROLE_FLAGS
    self.account_user_role.status = AccountUserRole::DEFAULT_ACCOUNT_ROLE_STATUS

  end

end

