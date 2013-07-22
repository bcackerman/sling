require "spec_helper"

describe SpeechesController do
  describe "routing" do

    it "routes to #index" do
      get("/speeches").should route_to("speeches#index")
    end

    it "routes to #new" do
      get("/speeches/new").should route_to("speeches#new")
    end

    it "routes to #show" do
      get("/speeches/1").should route_to("speeches#show", :id => "1")
    end

    it "routes to #edit" do
      get("/speeches/1/edit").should route_to("speeches#edit", :id => "1")
    end

    it "routes to #create" do
      post("/speeches").should route_to("speeches#create")
    end

    it "routes to #update" do
      put("/speeches/1").should route_to("speeches#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/speeches/1").should route_to("speeches#destroy", :id => "1")
    end

  end
end
