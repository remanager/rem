require 'rails_helper'

feature 'sign in' do
  background do
    @user = create :user
  end

  scenario 'signs the user in succesfully' do
    sign_in_with(@user.email, @user.password)
    expect(page).to have_content 'Logged in!'
  end
  scenario 'shows message when credentials are wrong' do
    sign_in_with(@user.email, 'bad_password')
    expect(page).to have_css '.flash.alert', text: 'Invalid credentials.'
  end

  def sign_in_with(email, password)
    visit log_in_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
end
