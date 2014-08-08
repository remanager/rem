require 'helpers/auth_helper'

feature 'Add new properties' do
  scenario 'new property is added in her realestate' do
    agent = create :user, :agent
    town = create :town, name: 'pretty_town'
    create :category, name: 'awesome'
    ['pool', 'fontain'].each { |n| create :detail, name: n }
    sign_in_as agent

    visit admin_properties_path
    expect(page).not_to have_css 'tbody > tr'

    click_on 'Create new property'
    fill_in 'Ref', with: 'nice_house'
    select 'pretty_town', from: 'Town'
    check 'awesome'
    check 'pool'
    click_on 'Save'

    expect(current_path).to end_with(admin_properties_path)
    other_property = create :property
    visit admin_properties_path
    expect(page).to have_content('nice_house')
    expect(page).not_to have_content(other_property.ref)

    click_on 'Edit'
    expect(page.all('input[type=checkbox][checked]').count).to eq(2)
  end
end
