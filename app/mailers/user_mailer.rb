class UserMailer < ActionMailer::Base
  default from: 'mailer.rem@gmail.com'

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'REM - Password reset.'
  end

  def approved(user)
    @user = user
    mail to: user.email, subject: 'REM - Your user have been approved!'
  end
end
