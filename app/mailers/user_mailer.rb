class UserMailer < ActionMailer::Base

  def confirm_email(user)
    validation = ValidationToken.confirm_email user
    @url = validation.url
    @user = user
    mail(to: @user.email, subject: 'Email address confirmation request')
  end

  def reset_password(user)
    validation = ValidationToken.reset_password user
    @url = validation.url
    @user = user
    mail(to: @user.email, subject: 'Password reset request')
  end

  def invite_user(account, user, token)
    @url = token.url
    @user = user
    @account = account
    mail(to: @user.email, subject: "Invitation to DBHistory.com account #{account.name}")
  end
end
