require 'rails_helper'

RSpec.describe "towns/index", :type => :view do
  before(:each) do
    assign(:towns, [
      Town.create!(
        :postcode => "Postcode",
        :name => "Name"
      ),
      Town.create!(
        :postcode => "Postcode",
        :name => "Name"
      )
    ])
  end

  it "renders a list of towns" do
    render
    assert_select "tr>td", :text => "Postcode".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
