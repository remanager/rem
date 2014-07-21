require 'rails_helper'

RSpec.describe "details/index", :type => :view do
  before(:each) do
    assign(:details, [
      Detail.create!(
        :name => "Name"
      ),
      Detail.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of details" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
