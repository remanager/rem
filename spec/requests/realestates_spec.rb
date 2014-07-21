require 'rails_helper'

RSpec.describe "Realestates", :type => :request do
  describe "GET /realestates" do
    it "works! (now write some real specs)" do
      get realestates_path
      expect(response.status).to be(200)
    end
  end
end
