require 'rails_helper'

RSpec.describe "realestates/new", :type => :view do
  before(:each) do
    assign(:realestate, Realestate.new(
      :name => "MyString",
      :description => "MyText",
      :address => "MyString",
      :user => nil
    ))
  end

  it "renders new realestate form" do
    render

    assert_select "form[action=?][method=?]", realestates_path, "post" do

      assert_select "input#realestate_name[name=?]", "realestate[name]"

      assert_select "textarea#realestate_description[name=?]", "realestate[description]"

      assert_select "input#realestate_address[name=?]", "realestate[address]"

      assert_select "input#realestate_user_id[name=?]", "realestate[user_id]"
    end
  end
end
