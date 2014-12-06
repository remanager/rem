require 'helpers/auth_helper'

feature 'user creation' do
  context 'admin role' do
    scenario 'can create' do
      admin = create :user_admin
      sign_in_as admin
      visit new_admin_user_path
      fill_in 'Email', with: 'agent@rem.com'
      fill_in 'Password', with: '1234test'
      fill_in 'Password confirmation', with: '1234test'
      fill_in 'Name', with: 'Vicent'
      fill_in 'Surname', with: 'Van Goool!!!'
      fill_in 'Address', with: 'Calle del suspiro, 33 - Alli'
      select 'agent', from: 'user_role'
      expect{ click_button 'Save' }.to change{ User.count }.by(1)
      expect(User.last.role.to_sym).to eq :agent
      expect(page).to have_css '.alert-box.notice', text: 'New user created!'
    end

    scenario 'can update' do
      admin = create :user_admin
      agent = create :user_agent_with_realestate
      sign_in_as admin
      visit edit_admin_user_path(id: agent.id)
      fill_in 'Email', with: 'owner@rem.com'
      fill_in 'Password', with: '1234test'
      fill_in 'Password confirmation', with: '1234test'
      select 'owner', from: 'user_role'
      click_button 'Save'
      expect(agent.reload.role.to_sym).to eq :owner
      expect(agent.email).to eq('owner@rem.com')
      expect(page).to have_css '.alert-box.notice', text: 'User updated!'
    end

    scenario 'can delete' do
      admin = create :user_admin
      owner = create :user
      sign_in_as admin
      visit admin_users_path
      expect{ page.find("tbody tr:contains('#{owner.email}') a:contains('Delete')").click }.to change{ User.count }.by(-1)
      expect(current_path).to end_with(admin_users_path)
      expect(page).to have_css '.alert-box.notice', text: 'User deleted!'
    end
  end

  scenario 'agent can create owner' do
    agent = create :user_agent_with_realestate
    sign_in_as agent
    visit new_admin_user_path
    fill_in 'Email', with: 'owner@rem.com'
    fill_in 'Password', with: '1234test'
    fill_in 'Password confirmation', with: '1234test'
    fill_in 'Name', with: 'Vicent'
    fill_in 'Surname', with: 'Van Goool!!!'
    fill_in 'Address', with: 'Calle del suspiro, 33 - Alli'
    expect{ click_button 'Save' }.to change{ User.count }.by(1)
    expect(User.last.role.to_sym).to eq :owner
    expect(page).to have_css '.alert-box.notice', text: 'New user created!'
  end

  scenario 'owner cannot create user' do
    owner = create :user
    sign_in_as owner
    visit new_admin_user_path
    expect(page).to have_css '.alert-box.alert', text: 'Not authorized.'
    expect(current_path).to end_with(admin_dashboard_path)
  end
end
