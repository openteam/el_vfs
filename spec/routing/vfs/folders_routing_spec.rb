require "spec_helper"

module Vfs

  describe FoldersController do
    describe "routing" do

      it "routes to #index" do
        get("/vfs/folders").should route_to("vfs/folders#index")
      end

      it "routes to #new" do
        get("/vfs/folders/new").should route_to("vfs/folders#new")
      end

      it "routes to #show" do
        get("/vfs/folders/1").should route_to("vfs/folders#show", :id => "1")
      end

      it "routes to #edit" do
        get("/vfs/folders/1/edit").should route_to("vfs/folders#edit", :id => "1")
      end

      it "routes to #create" do
        post("/vfs/folders").should route_to("vfs/folders#create")
      end

      it "routes to #update" do
        put("/vfs/folders/1").should route_to("vfs/folders#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/vfs/folders/1").should route_to("vfs/folders#destroy", :id => "1")
      end

    end
  end

end
