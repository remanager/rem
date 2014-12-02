class UserMailer < ActionMailer::Base
  default from: 'mailer.rem@gmail.com'

  def test(email)
    mail to: email, subject: 'testing'
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Password reset'
  end
end
