require "spec_helper"

describe Vfs::FilesController do
  describe "routing" do

    it "routes to #index" do
      get("/vfs/files").should route_to("vfs/files#index")
    end

    it "routes to #new" do
      get("/vfs/files/new").should route_to("vfs/files#new")
    end

    it "routes to #show" do
      get("/vfs/files/1").should route_to("vfs/files#show", :id => "1")
    end

    it "routes to #edit" do
      get("/vfs/files/1/edit").should route_to("vfs/files#edit", :id => "1")
    end

    it "routes to #create" do
      post("/vfs/files").should route_to("vfs/files#create")
    end

    it "routes to #update" do
      put("/vfs/files/1").should route_to("vfs/files#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/vfs/files/1").should route_to("vfs/files#destroy", :id => "1")
    end

  end
end
