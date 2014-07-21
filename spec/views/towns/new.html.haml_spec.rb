require 'rails_helper'

RSpec.describe "towns/new", :type => :view do
  before(:each) do
    assign(:town, Town.new(
      :postcode => "MyString",
      :name => "MyString"
    ))
  end

  it "renders new town form" do
    render

    assert_select "form[action=?][method=?]", towns_path, "post" do

      assert_select "input#town_postcode[name=?]", "town[postcode]"

      assert_select "input#town_name[name=?]", "town[name]"
    end
  end
end
