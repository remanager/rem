require 'helpers/auth_helper'

describe 'new agent from public site' do
  let!(:admin) { FactoryGirl.create(:user_admin) }

  it 'should be able to register' do
    visit '/'
    fill_in 'Email', with: 'ramonet@example.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password confirmation', with: '123456'
    fill_in 'Name', with: 'Ramonet'
    fill_in 'Surname', with: 'El monet'
    fill_in 'Address', with: 'Carrer del arbre, 13 - Mountain lake'
    expect { click_button 'Save' }.to change(User, :count).by(1)

    visit '/admin'
    expect(current_path).to eq(login_path(locale: :en))

    fill_in 'Email', with: 'ramonet@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    # expect(current_path).to eq(login_path(locale: :en))
    expect(page).to have_css('.alert', text: 'You user, is still approval pending.')

    sign_in_as admin
    expect(page).to have_content 'Ramonet El monet - ramonet@example.com'
    click_link 'Accept'
    expect(User.find_by(email: 'ramonet@example.com').status).to eq(User::STATUS_OK)

    visit logout_path
    visit login_path
    fill_in 'Email', with: 'ramonet@example.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'
    expect(current_path).to eq(admin_dashboard_path(locale: :en))
    expect(page).to have_css('.notice', text: 'Logged in')
  end
end
