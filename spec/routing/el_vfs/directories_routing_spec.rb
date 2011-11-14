require "spec_helper"

module ElVfs

  describe DirectoriesController do
    describe "routing" do

      it "routes to #index" do
        get("/el_vfs/directories").should route_to("el_vfs/directories#index")
      end

      it "routes to #new" do
        get("/el_vfs/directories/new").should route_to("el_vfs/directories#new")
      end

      it "routes to #show" do
        get("/el_vfs/directories/1").should route_to("el_vfs/directories#show", :id => "1")
      end

      it "routes to #edit" do
        get("/el_vfs/directories/1/edit").should route_to("el_vfs/directories#edit", :id => "1")
      end

      it "routes to #create" do
        post("/el_vfs/directories").should route_to("el_vfs/directories#create")
      end

      it "routes to #update" do
        put("/el_vfs/directories/1").should route_to("el_vfs/directories#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/el_vfs/directories/1").should route_to("el_vfs/directories#destroy", :id => "1")
      end

    end
  end

end
