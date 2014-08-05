require 'helpers/auth_helper'

feature 'dashboard' do
  scenario 'admin user' do
    admin = create :user, :admin
    sign_in_as admin
    expect(current_path).to end_with(admin_dashboard_path)
    expect(page).to have_css 'h1', text: 'Dashboard'
    expect(page).to have_css 'nav', text: 'Users'
    expect(page).to have_css 'nav', text: 'Real Estates'
  end

  scenario 'agent user' do
    agent = create :user, :agent
    sign_in_as agent
    expect(current_path).to end_with(admin_dashboard_path)
    expect(page).to have_css 'h1', text: 'Dashboard'
    expect(page).to have_css 'nav', text: 'Users'
    expect(page).not_to have_css 'nav', text: 'Real Estates'
    expect(page).to have_css 'nav', text: 'Real Estate'
    expect(page).to have_css 'nav', text: 'Properties'
    expect(page).to have_css 'nav', text: 'Categories'
  end

  scenario 'owner user' do
    owner = create :user, :owner
    sign_in_as owner
    expect(current_path).to end_with(admin_dashboard_path)
    expect(page).to have_css 'h1', text: 'Dashboard'
    expect(page).not_to have_css 'nav', text: 'Users'
    expect(page).not_to have_css 'nav', text: 'Real Estates'
    expect(page).not_to have_css 'nav', text: 'Real Estate'
    expect(page).to have_css 'nav', text: 'Properties'
    expect(page).not_to have_css 'nav', text: 'Categories'
  end
end
