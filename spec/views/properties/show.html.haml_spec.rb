require 'rails_helper'

RSpec.describe "properties/show", :type => :view do
  before(:each) do
    @property = assign(:property, Property.create!(
      :ref => "Ref",
      :town => nil,
      :user => nil,
      :category => nil,
      :detail => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Ref/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
