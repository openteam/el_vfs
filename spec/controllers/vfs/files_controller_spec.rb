require 'spec_helper'

describe Vfs::FilesController do

  def valid_attributes
    Fabricate.attributes_for :file
  end

  let(:file) { Fabricate :file }

  alias :create_file :file

  describe "GET index" do
    it "assigns all files as @files" do
      create_file
      get :index
      assigns(:files).should eq([file])
    end
  end

  describe "GET show" do
    it "assigns the requested file as @file" do
      get :show, :id => file.id.to_s
      assigns(:file).should eq(file)
    end
  end

  describe "GET new" do
    it "assigns a new file as @file" do
      get :new
      assigns(:file).should be_a_new(Vfs::File)
    end
  end

  describe "GET edit" do
    it "assigns the requested file as @file" do
      get :edit, :id => file.id.to_s
      assigns(:file).should eq(file)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Vfs::File" do
        expect {
          post :create, :file => valid_attributes
        }.to change(Vfs::File, :count).by(1)
      end

      it "assigns a newly created file as @file" do
        post :create, :file => valid_attributes
        assigns(:file).should be_a(Vfs::File)
        assigns(:file).should be_persisted
      end

      it "redirects to the created file" do
        post :create, :file => valid_attributes
        response.should redirect_to(Vfs::File.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved file as @file" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vfs::File.any_instance.stub(:save).and_return(false)
        post :create, :file => {}
        assigns(:file).should be_a_new(Vfs::File)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Vfs::File.any_instance.stub(:save).and_return(false)
        post :create, :file => {}
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested file" do
        file = Vfs::File.create! valid_attributes
        # Assuming there are no other files in the database, this
        # specifies that the Vfs::File created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Vfs::File.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => file.id, :file => {'these' => 'params'}
      end

      it "assigns the requested file as @file" do
        file = Vfs::File.create! valid_attributes
        put :update, :id => file.id, :file => valid_attributes
        assigns(:file).should eq(file)
      end

      it "redirects to the file" do
        file = Vfs::File.create! valid_attributes
        put :update, :id => file.id, :file => valid_attributes
        response.should redirect_to(file)
      end
    end

    describe "with invalid params" do
      it "assigns the file as @file" do
        file = Vfs::File.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Vfs::File.any_instance.stub(:save).and_return(false)
        put :update, :id => file.id.to_s, :file => {}
        assigns(:file).should eq(file)
      end

      it "re-renders the 'edit' template" do
        file = Vfs::File.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Vfs::File.any_instance.stub(:save).and_return(false)
        put :update, :id => file.id.to_s, :file => {}
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested file" do
      file = Vfs::File.create! valid_attributes
      expect {
        delete :destroy, :id => file.id.to_s
      }.to change(Vfs::File, :count).by(-1)
    end

    it "redirects to the files list" do
      file = Vfs::File.create! valid_attributes
      delete :destroy, :id => file.id.to_s
      response.should redirect_to(files_path)
    end
  end

end
