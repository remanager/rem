require 'helpers/auth_helper'

feature 'user creation' do
  context 'admin role' do
    scenario 'can create' do
      admin = create :user, :admin
      sign_in_as admin
      visit new_admin_user_path
      fill_in 'Email', with: 'agent@rem.com'
      fill_in 'Password', with: '1234test'
      fill_in 'Password confirmation', with: '1234test'
      select 'agent', from: 'Role'
      expect{ click_button 'Create' }.to change{ User.count }.by(1)
      expect(User.last.role.to_sym).to eq :agent
      expect(page).to have_css '.flash.notice', text: 'New user created!'
    end

    scenario 'can update' do
      admin = create :user, :admin
      agent = create :user, :agent
      sign_in_as admin
      visit edit_admin_user_path(id: agent.id)
      fill_in 'Email', with: 'owner@rem.com'
      fill_in 'Password', with: '1234test'
      fill_in 'Password confirmation', with: '1234test'
      select 'owner', from: 'Role'
      click_button 'Edit'
      expect(agent.reload.role.to_sym).to eq :owner
      expect(agent.email).to eq('owner@rem.com')
      expect(page).to have_css '.flash.notice', text: 'User updated!'
    end

    scenario 'can delete' do
      admin = create :user, :admin
      owner = create :user, :owner
      sign_in_as admin
      visit admin_users_path
      expect{ page.find("tbody tr:contains('#{owner.email}') a:contains('Delete')").click }.to change{ User.count }.by(-1)
      expect(current_path).to end_with(admin_users_path)
      expect(page).to have_css '.flash.notice', text: 'User deleted!'
    end
  end

  scenario 'agent can create owner' do
    agent = create :user, :agent
    sign_in_as agent
    visit new_admin_user_path
    fill_in 'Email', with: 'owner@rem.com'
    fill_in 'Password', with: '1234test'
    fill_in 'Password confirmation', with: '1234test'
    expect{ click_button 'Create' }.to change{ User.count }.by(1)
    expect(User.last.role.to_sym).to eq :owner
    expect(page).to have_css '.flash.notice', text: 'New user created!'
  end

  scenario 'owner cannot create user' do
    owner = create :user, :owner
    sign_in_as owner
    visit new_admin_user_path
    expect(page).to have_css '.flash.alert', text: 'Not authorized.'
    expect(current_path).to end_with(admin_dashboard_path)
  end
end
