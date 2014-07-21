require 'rails_helper'

RSpec.describe "towns/show", :type => :view do
  before(:each) do
    @town = assign(:town, Town.create!(
      :postcode => "Postcode",
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Postcode/)
    expect(rendered).to match(/Name/)
  end
end
