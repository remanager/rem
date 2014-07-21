require "rails_helper"

RSpec.describe TownsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/towns").to route_to("towns#index")
    end

    it "routes to #new" do
      expect(:get => "/towns/new").to route_to("towns#new")
    end

    it "routes to #show" do
      expect(:get => "/towns/1").to route_to("towns#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/towns/1/edit").to route_to("towns#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/towns").to route_to("towns#create")
    end

    it "routes to #update" do
      expect(:put => "/towns/1").to route_to("towns#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/towns/1").to route_to("towns#destroy", :id => "1")
    end

  end
end
