require 'rails_helper'

RSpec.describe "towns/edit", :type => :view do
  before(:each) do
    @town = assign(:town, Town.create!(
      :postcode => "MyString",
      :name => "MyString"
    ))
  end

  it "renders the edit town form" do
    render

    assert_select "form[action=?][method=?]", town_path(@town), "post" do

      assert_select "input#town_postcode[name=?]", "town[postcode]"

      assert_select "input#town_name[name=?]", "town[name]"
    end
  end
end
