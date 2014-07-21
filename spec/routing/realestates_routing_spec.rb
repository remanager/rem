require "rails_helper"

RSpec.describe RealestatesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/realestates").to route_to("realestates#index")
    end

    it "routes to #new" do
      expect(:get => "/realestates/new").to route_to("realestates#new")
    end

    it "routes to #show" do
      expect(:get => "/realestates/1").to route_to("realestates#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/realestates/1/edit").to route_to("realestates#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/realestates").to route_to("realestates#create")
    end

    it "routes to #update" do
      expect(:put => "/realestates/1").to route_to("realestates#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/realestates/1").to route_to("realestates#destroy", :id => "1")
    end

  end
end
