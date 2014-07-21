require 'rails_helper'

RSpec.describe "realestates/index", :type => :view do
  before(:each) do
    assign(:realestates, [
      Realestate.create!(
        :name => "Name",
        :description => "MyText",
        :address => "Address",
        :user => nil
      ),
      Realestate.create!(
        :name => "Name",
        :description => "MyText",
        :address => "Address",
        :user => nil
      )
    ])
  end

  it "renders a list of realestates" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
