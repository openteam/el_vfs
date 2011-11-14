require "spec_helper"

describe ElVfs::FilesController do
  describe "routing" do

    it "routes to #index" do
      get("/el_vfs/files").should route_to("el_vfs/files#index")
    end

    it "routes to #new" do
      get("/el_vfs/files/new").should route_to("el_vfs/files#new")
    end

    it "routes to #show" do
      get("/el_vfs/files/1").should route_to("el_vfs/files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/el_vfs/files/1/edit").should route_to("el_vfs/files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/el_vfs/files").should route_to("el_vfs/files#create")
    end

    it "routes to #update" do
      put("/el_vfs/files/1").should route_to("el_vfs/files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/el_vfs/files/1").should route_to("el_vfs/files#destroy", :id => "1")
    end

  end
end
