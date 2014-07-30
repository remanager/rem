# spec/helpers/auth_helper.rb

  def sign_in_as(user)
    sign_in_with(user.email, user.password)
  end

  def sign_in_with(email, password)
    visit login_path
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    click_button 'Log in'
  end
