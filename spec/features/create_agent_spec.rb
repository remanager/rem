require 'helpers/auth_helper'

feature 'create new agent' do
  scenario 'admin can create user' do
    admin = create :user, :admin
    sign_in_as admin
    visit new_admin_user_path
    fill_in 'Email', with: 'agent@rem.com'
    fill_in 'Password', with: '1234test'
    fill_in 'Password confirmation', with: '1234test'
    select 'agent', from: 'Role'
    #click_button 'Create'
    expect{ click_button 'Create' }.to change{ User.count }.by(1)
    expect(User.last.role).to eq :agent
    expect(page).to have_css '.flash.notice', text: 'New agent created!'
  end

  scenario 'non-admin cannot create user' do
    user = create :user
    sign_in_as user
    visit new_admin_user_path
    expect(page).to have_css '.flash.alert', text: 'Not authorized.'
    expect(current_path).to eq(root_path)
  end
end
