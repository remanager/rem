require 'rails_helper'

RSpec.describe "details/show", :type => :view do
  before(:each) do
    @detail = assign(:detail, Detail.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
