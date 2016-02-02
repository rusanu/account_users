class AccountMailer < ActionMailer::Base
  def welcome_email(account, user)
    @account = account
    @user = user
    mail(to: @user.email)
  end
end
