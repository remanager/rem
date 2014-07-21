require 'rails_helper'

RSpec.describe "realestates/edit", :type => :view do
  before(:each) do
    @realestate = assign(:realestate, Realestate.create!(
      :name => "MyString",
      :description => "MyText",
      :address => "MyString",
      :user => nil
    ))
  end

  it "renders the edit realestate form" do
    render

    assert_select "form[action=?][method=?]", realestate_path(@realestate), "post" do

      assert_select "input#realestate_name[name=?]", "realestate[name]"

      assert_select "textarea#realestate_description[name=?]", "realestate[description]"

      assert_select "input#realestate_address[name=?]", "realestate[address]"

      assert_select "input#realestate_user_id[name=?]", "realestate[user_id]"
    end
  end
end
