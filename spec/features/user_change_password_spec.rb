require 'rails_helper'

feature 'user reset its password' do

  background do
  end

  scenario 'user doesn\'t exist' do
    visit new_password_reset_path
    fill_in 'Email', with: 'user@example.com'
    click_button 'Reset password'

    expect(page).to have_css '.flash.alert', text: 'Email not registered.'
  end

  scenario 'user exists' do
    agent = create :user, :agent
    visit new_password_reset_path
    fill_in 'Email', with: agent.email
    click_button 'Reset password'

    expect(page).to have_css '.flash.notice', text: 'Email sent with password reset instructions.'
    expect(current_path).to eq(login_path)
    expect(last_email.to).to include(agent.email)
  end
end
