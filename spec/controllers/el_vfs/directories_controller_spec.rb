require 'spec_helper'

module ElVfs
  describe DirectoriesController do

    def valid_attributes
      { :file_name => 'directory' }
    end

    let(:directory) { Fabricate :directory }
    alias :create_directory :directory


    describe "GET index" do
      it "assigns all directories as @directories" do
        create_directory
        get :index
        assigns(:directories).should include(directory)
      end
    end

    describe "GET show" do
      it "assigns the requested directory as @directory" do
        get :show, :id => directory.id.to_s
        assigns(:directory).should eq(directory)
      end
    end

    describe "GET new" do
      it "assigns a new directory as @directory" do
        get :new
        assigns(:directory).should be_a_new(Directory)
      end
    end

    describe "GET edit" do
      it "assigns the requested directory as @directory" do
        get :edit, :id => directory.id.to_s
        assigns(:directory).should eq(directory)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Directory" do
          expect {
            post :create, :directory => valid_attributes
          }.to change(Directory, :count).by(1)
        end

        it "assigns a newly created directory as @directory" do
          post :create, :directory => valid_attributes
          assigns(:directory).should be_a(Directory)
          assigns(:directory).should be_persisted
        end

        it "redirects to the created directory" do
          post :create, :directory => valid_attributes
          response.should redirect_to(Directory.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved directory as @directory" do
          # Trigger the behavior that occurs when invalid params are submitted
          Directory.any_instance.stub(:save).and_return(false)
          post :create, :directory => {}
          assigns(:directory).should be_a_new(Directory)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          Directory.any_instance.stub(:save).and_return(false)
          post :create, :directory => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested directory" do
          Directory.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => directory.id, :directory => {'these' => 'params'}
        end

        it "assigns the requested directory as @directory" do
          put :update, :id => directory.id, :directory => valid_attributes
          assigns(:directory).should eq(directory)
        end

        it "redirects to the directory" do
          put :update, :id => directory.id, :directory => valid_attributes
          response.should redirect_to(directory)
        end
      end

      describe "with invalid params" do
        it "assigns the directory as @directory" do
          put :update, :id => directory.id.to_s, :directory => {}
          assigns(:directory).should eq(directory)
        end

        it "re-renders the 'edit' template" do
          Directory.any_instance.stub(:save).and_return(false)
          put :update, :id => directory.id.to_s, :directory => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested directory" do
        create_directory
        expect {
          delete :destroy, :id => directory.id.to_s
        }.to change(Directory, :count).by(-1)
      end

      it "redirects to the directories list" do
        delete :destroy, :id => directory.id.to_s
        response.should redirect_to(directories_path)
      end
    end

  end
end
