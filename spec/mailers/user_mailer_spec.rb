describe UserMailer do
  context 'password reset' do
    it 'sends user password reset url' do
      user = create :user, :agent, password_reset_token: 'my_reset_token'
      mail = UserMailer.password_reset(user)

      expect(mail.subject).to eq('REM - Password reset.')
      expect(mail.to).to include(user.email)
      expect(mail.body).to match(edit_password_reset_path(user.password_reset_token))
    end
  end
end
