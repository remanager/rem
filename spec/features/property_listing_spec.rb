require 'helpers/auth_helper'

feature 'property listing' do
  background do
    @agent = create :user_agent_with_realestate
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

  scenario 'owner role shows owned' do
    owner = create :user
    property = create :property, realestate: @agent.realestate, user: owner
    sign_in_as owner
    visit admin_properties_path
    expect(page.all('tbody tr').count).to eq(1)
    expect(page.body).to have_content(property.ref)
  end
end
