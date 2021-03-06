describe User do
  describe 'validations' do
    it 'has email' do
      user = User.new
      expect(user).not_to be_valid
      expect(user.errors.messages[:email]).not_to be_nil
    end
  end

  describe 'associations' do
    it { is_expected.to respond_to(:realestate) }
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
    subject { create :user_agent_with_realestate }

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

  describe '#my_users' do
    context 'admin role' do
      subject { create :user_admin }

      it 'gets all users' do
        5.times { create :user_agent_with_realestate }
        3.times { create :user }

        expect(subject.my_users).to eq(User.all)
      end
    end

    context 'agent_role' do
      subject { create :user_agent_with_realestate }

      it 'gets realestate users' do
        another_agent = create :user_agent_with_realestate
        FactoryGirl.create_list(:property, 2, realestate: another_agent.realestate)
        my_owners = []
        3.times { my_owners << create(:property, realestate: subject.realestate) }
        my_owners.map! { |p| p.user.id }

        expect(subject.my_users.pluck(:id)).to contain_exactly(*my_owners)
      end
    end

    describe '#my_properties' do
      context 'admin role' do
        it 'gets all properties' do
          admin = create :user_admin
          agent1 = create :user_agent_with_realestate
          agent2 = create :user_agent_with_realestate
          2.times { create :property, realestate: agent1.realestate }
          3.times { create :property, realestate: agent2.realestate }

          expect(admin.my_properties.count).to eq(5)
        end
      end

      context 'agent role' do
        it 'gets realestate properties'do
          agent1 = create :user_agent_with_realestate
          agent2 = create :user_agent_with_realestate
          2.times { create :property, realestate: agent1.realestate }
          3.times { create :property, realestate: agent2.realestate }

          expect(agent1.my_properties.count).to eq(2)
          expect(agent2.my_properties.count).to eq(3)
        end

      end

      context 'owner role' do
        it 'gets owned properties'do
          owner = create :user
          agent1 = create :user_agent_with_realestate
          2.times { create :property, realestate: agent1.realestate }
          property = create :property, realestate: agent1.realestate, user: owner

          expect(owner.my_properties).to eq([property])
        end
      end
    end
  end
end
