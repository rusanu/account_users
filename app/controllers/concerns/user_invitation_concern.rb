require 'securerandom'

module UserInvitationConcern 
  extend ActiveSupport::Concern

  def create_user_invitation(account, email)
    user = nil
    token = nil
    role = nil
    User.transaction do
      user = User.find_or_create_by(email: email) do |u|
        u.name = email
        u.status = User::USER_STATUS_PROVISIONAL_INVITED
        u.password_hash = SecureRandom.hex 20  # unknown password, user will have to reset it
      end
      role = AccountUserRole.create(
          account_id: account.id,
          user_id: user.id,
          status: AccountUserRole::ACCOUNT_ROLE_STATUS_PROVISIONAL)
      token = ValidationToken.invite_user user
    end
    UserMailer.invite_user(account, user, token).deliver_now
    return user,role
  end

end
