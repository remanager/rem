require 'rails_helper'

RSpec.describe "Towns", :type => :request do
  describe "GET /towns" do
    it "works! (now write some real specs)" do
      get towns_path
      expect(response.status).to be(200)
    end
  end
end
