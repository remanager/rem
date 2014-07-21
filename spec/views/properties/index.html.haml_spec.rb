require 'rails_helper'

RSpec.describe "properties/index", :type => :view do
  before(:each) do
    assign(:properties, [
      Property.create!(
        :ref => "Ref",
        :town => nil,
        :user => nil,
        :category => nil,
        :detail => nil
      ),
      Property.create!(
        :ref => "Ref",
        :town => nil,
        :user => nil,
        :category => nil,
        :detail => nil
      )
    ])
  end

  it "renders a list of properties" do
    render
    assert_select "tr>td", :text => "Ref".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
