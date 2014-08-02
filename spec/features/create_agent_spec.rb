require 'helpers/auth_helper'

feature 'user creation' do
  scenario 'admin can create any user' do
    admin = create :user, :admin
    sign_in_as admin
    visit new_admin_user_path
    fill_in 'Email', with: 'agent@rem.com'
    fill_in 'Password', with: '1234test'
    fill_in 'Password confirmation', with: '1234test'
    select 'agent', from: 'Role'
    expect{ click_button 'Create' }.to change{ User.count }.by(1)
    expect(User.last.role.to_sym).to eq :agent
    expect(page).to have_css '.flash.notice', text: 'New agent created!'
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
    expect(page).to have_css '.flash.notice', text: 'New agent created!'
  end
  scenario 'owner cannot create user' do
    owner = create :user, :owner
    sign_in_as owner
    visit new_admin_user_path
    expect(page).to have_css '.flash.alert', text: 'Not authorized.'
    expect(current_path).to eq(root_path)
  end
end
