require 'rails_helper'

RSpec.describe "realestates/show", :type => :view do
  before(:each) do
    @realestate = assign(:realestate, Realestate.create!(
      :name => "Name",
      :description => "MyText",
      :address => "Address",
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Address/)
    expect(rendered).to match(//)
  end
end
