require 'rails_helper'

RSpec.describe "details/new", :type => :view do
  before(:each) do
    assign(:detail, Detail.new(
      :name => "MyString"
    ))
  end

  it "renders new detail form" do
    render

    assert_select "form[action=?][method=?]", details_path, "post" do

      assert_select "input#detail_name[name=?]", "detail[name]"
    end
  end
end
