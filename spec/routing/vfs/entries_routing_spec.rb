require "spec_helper"

module Vfs
  describe EntriesController do

    describe "routing" do

      it "routes to #index" do
        get("/vfs/entries").should route_to("vfs/entries#index")
      end

      it "routes to #new" do
        get("/vfs/entries/new").should route_to("vfs/entries#new")
      end

      it "routes to #show" do
        get("/vfs/entries/1").should route_to("vfs/entries#show", :id => "1")
      end

      it "routes to #edit" do
        get("/vfs/entries/1/edit").should route_to("vfs/entries#edit", :id => "1")
      end

      it "routes to #create" do
        post("/vfs/entries").should route_to("vfs/entries#create")
      end

      it "routes to #update" do
        put("/vfs/entries/1").should route_to("vfs/entries#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/vfs/entries/1").should route_to("vfs/entries#destroy", :id => "1")
      end

    end
  end
end
