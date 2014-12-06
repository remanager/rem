feature 'user reset its password' do
  background do
    visit new_password_reset_path
  end

  scenario 'user doesn\'t exist' do
    fill_in 'Email', with: 'faked@example.com'
    click_button 'Reset password'

    expect(page).to have_css '.alert-box.alert', text: 'Email not registered.'
  end

  scenario 'user exists' do
    agent = create :user, :agent
    fill_in 'Email', with: agent.email
    click_button 'Reset password'

    expect(page).to have_css '.alert-box.notice', text: 'Email sent with password reset instructions.'
    expect(current_path).to end_with(login_path)
    expect(last_email.to).to include(agent.email)
  end
end
