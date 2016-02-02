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
end
