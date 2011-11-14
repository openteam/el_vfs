require "spec_helper"

module ElVfs
  describe EntriesController do
    describe "routing" do
      it "routes to #index" do
        get("/el_vfs/entries").should route_to("el_vfs/entries#index")
      end

      it "routes to #new" do
        get("/el_vfs/entries/new").should route_to("el_vfs/entries#new")
      end

      it "routes to #show" do
        get("/el_vfs/entries/1").should route_to("el_vfs/entries#show", :id => "1")
      end

      it "routes to #edit" do
        get("/el_vfs/entries/1/edit").should route_to("el_vfs/entries#edit", :id => "1")
      end

      it "routes to #create" do
        post("/el_vfs/entries").should route_to("el_vfs/entries#create")
      end

      it "routes to #update" do
        put("/el_vfs/entries/1").should route_to("el_vfs/entries#update", :id => "1")
      end

      it "routes to #destroy" do
        delete("/el_vfs/entries/1").should route_to("el_vfs/entries#destroy", :id => "1")
      end
    end
  end
end
