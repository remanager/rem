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

    sign_in_with 'ramonet@example.com', '123456'
    expect(current_path).to eq(login_path(locale: :en))
    expect(page).to have_css('.alert', text: 'You user, is still approval pending.')

    sign_in_as admin
    expect(page).to have_content 'Ramonet El monet - ramonet@example.com'
    click_link 'Accept'
    ramonet = User.find_by(email: 'ramonet@example.com')
    expect(ramonet.status).to eq(User::STATUS_OK)
    expect(ramonet.realestate).not_to be_nil

    visit logout_path
    sign_in_with 'ramonet@example.com', '123456'
    expect(current_path).to eq(edit_admin_realestate_path(locale: :en, id: ramonet.realestate))
    expect(page).to have_css('.notice', text: 'Logged in')

    fill_in 'Realestate name', with: 'Nice Your House'
    fill_in 'Phone', with: '902202122'
    click_button 'Save'
    expect(ramonet.reload.realestate.name).to eq 'Nice Your House'
    click_link 'Publish'
    expect(ramonet.reload.realestate).to be_published
    expect(current_path).to eq admin_dashboard_path(locale: :en)
  end
end
