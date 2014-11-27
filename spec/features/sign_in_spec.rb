require 'helpers/auth_helper'

feature 'sign in' do
  background do
    @agent = create :user, :agent
  end

  scenario 'signs the user in succesfully' do
    sign_in_as @agent
    expect(page).to have_css '.flash.notice', text: 'Logged in!'
  end

  scenario 'shows message when credentials are wrong' do
    sign_in_with(@agent.email, 'bad_password')
    expect(page).to have_css '.flash.notice', text: 'Invalid email or password.'
  end

end
