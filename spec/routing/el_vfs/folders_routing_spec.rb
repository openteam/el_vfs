require "spec_helper"

module ElVfs

  describe FoldersController do
    describe "routing" do

      it "routes to #index" do
        get("/el_vfs/folders").should route_to("el_vfs/folders#index")
      end

      it "routes to #new" do
        get("/el_vfs/folders/new").should route_to("el_vfs/folders#new")
      end

      it "routes to #show" do
        get("/el_vfs/folders/1").should route_to("el_vfs/folders#show", :id => "1")
      end

      it "routes to #edit" do
        get("/el_vfs/folders/1/edit").should route_to("el_vfs/folders#edit", :id => "1")
      end

      it "routes to #create" do
        post("/el_vfs/folders").should route_to("el_vfs/folders#create")
      end

      it "routes to #update" do
        put("/el_vfs/folders/1").should route_to("el_vfs/folders#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/el_vfs/folders/1").should route_to("el_vfs/folders#destroy", :id => "1")
      end

    end
  end

end
