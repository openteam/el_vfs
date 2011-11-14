require 'spec_helper'

module ElVfs
  describe FoldersController do

    def valid_attributes
      Fabricate.attributes_for :folder
    end

    let(:folder) { Fabricate :folder }
    alias :create_folder :folder


    describe "GET index" do
      it "assigns all folders as @folders" do
        create_folder
        get :index
        assigns(:folders).should include(folder)
      end
    end

    describe "GET show" do
      it "assigns the requested folder as @folder" do
        get :show, :id => folder.id.to_s
        assigns(:folder).should eq(folder)
      end
    end

    describe "GET new" do
      it "assigns a new folder as @folder" do
        get :new
        assigns(:folder).should be_a_new(Folder)
      end
    end

    describe "GET edit" do
      it "assigns the requested folder as @folder" do
        get :edit, :id => folder.id.to_s
        assigns(:folder).should eq(folder)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Folder" do
          expect {
            post :create, :folder => valid_attributes
          }.to change(Folder, :count).by(1)
        end

        it "assigns a newly created folder as @folder" do
          post :create, :folder => valid_attributes
          assigns(:folder).should be_a(Folder)
          assigns(:folder).should be_persisted
        end

        it "redirects to the created folder" do
          post :create, :folder => valid_attributes
          response.should redirect_to(Folder.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved folder as @folder" do
          # Trigger the behavior that occurs when invalid params are submitted
          Folder.any_instance.stub(:save).and_return(false)
          post :create, :folder => {}
          assigns(:folder).should be_a_new(Folder)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Folder.any_instance.stub(:save).and_return(false)
          post :create, :folder => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested folder" do
          Folder.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => folder.id, :folder => {'these' => 'params'}
        end

        it "assigns the requested folder as @folder" do
          put :update, :id => folder.id, :folder => valid_attributes
          assigns(:folder).should eq(folder)
        end

        it "redirects to the folder" do
          put :update, :id => folder.id, :folder => valid_attributes
          response.should redirect_to(folder)
        end
      end

      describe "with invalid params" do
        it "assigns the folder as @folder" do
          put :update, :id => folder.id.to_s, :folder => {}
          assigns(:folder).should eq(folder)
        end

        it "re-renders the 'edit' template" do
          Folder.any_instance.stub(:save).and_return(false)
          put :update, :id => folder.id.to_s, :folder => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested folder" do
        create_folder
        expect {
          delete :destroy, :id => folder.id.to_s
        }.to change(Folder, :count).by(-1)
      end

      it "redirects to the folders list" do
        delete :destroy, :id => folder.id.to_s
        response.should redirect_to(folders_path)
      end
    end

  end
end
