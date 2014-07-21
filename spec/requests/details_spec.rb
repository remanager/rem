require 'rails_helper'

RSpec.describe "Details", :type => :request do
  describe "GET /details" do
    it "works! (now write some real specs)" do
      get details_path
      expect(response.status).to be(200)
    end
  end
end
