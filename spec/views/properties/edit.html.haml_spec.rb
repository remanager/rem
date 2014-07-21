require 'rails_helper'

RSpec.describe "properties/edit", :type => :view do
  before(:each) do
    @property = assign(:property, Property.create!(
      :ref => "MyString",
      :town => nil,
      :user => nil,
      :category => nil,
      :detail => nil
    ))
  end

  it "renders the edit property form" do
    render

    assert_select "form[action=?][method=?]", property_path(@property), "post" do

      assert_select "input#property_ref[name=?]", "property[ref]"

      assert_select "input#property_town_id[name=?]", "property[town_id]"

      assert_select "input#property_user_id[name=?]", "property[user_id]"

      assert_select "input#property_category_id[name=?]", "property[category_id]"

      assert_select "input#property_detail_id[name=?]", "property[detail_id]"
    end
  end
end
