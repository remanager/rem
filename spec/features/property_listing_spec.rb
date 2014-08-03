require 'helpers/auth_helper'

feature 'property listing' do
  background do
    @agent = create :user, :agent
    realestate = @agent.realestate
    2.times { create :property, realestate: realestate }
    other_agent = create :user, :agent
    other_realestate = other_agent.realestate
    3.times { create :property, realestate: other_realestate }
  end

  scenario 'admin role shows all' do
    admin = create :user, :admin
    sign_in_as admin
    visit admin_properties_path
    expect(page.all('tbody tr').count).to eq(5)
  end

  scenario 'agent role shows from realestate' do
    sign_in_as @agent
    visit admin_properties_path
    expect(page.all('tbody tr').count).to eq(2)
  end

  scenario 'owner role shows owned'
end
