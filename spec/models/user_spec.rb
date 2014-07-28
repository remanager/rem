describe User do
  describe 'validations' do
    it 'has email' do
      user = User.new
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).not_to be_nil
    end
  end

  describe 'filters' do
    it 'generates auth_token before saving' do
      user = build :user
      expect(user.auth_token).to be_nil
      expect(user.save).to eq(true)
      expect(user.auth_token).not_to be_nil
    end
  end

  describe '#send_password_reset' do
    subject { create :user, :agent }

    it 'generates a unique password_reset_token each time' do
      subject.send_password_reset
      last_token = subject.password_reset_token
      subject.send_password_reset
      expect(subject.password_reset_token).not_to eq(last_token)
    end

    it 'saves the time the password reset was sent' do
      subject.send_password_reset
      subject.reload
      expect(subject.password_reset_sent_at).to be_within(1.second).of(Time.zone.now)
    end

    it 'delivers email to subject' do
      subject.send_password_reset
      expect(last_email.to).to include(subject.email)
    end
  end
end
