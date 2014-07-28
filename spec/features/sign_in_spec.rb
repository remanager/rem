require 'helpers/auth_helper'

feature 'sign in' do
  background do
    @user = create :user
  end

  scenario 'signs the user in succesfully' do
    sign_in_as @user
    expect(page).to have_content 'Logged in!'
  end
  scenario 'shows message when credentials are wrong' do
    sign_in_with(@user.email, 'bad_password')
    expect(page).to have_css '.flash.alert', text: 'Invalid email or password.'
  end

end
