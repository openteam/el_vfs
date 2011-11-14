require 'spec_helper'

module ElVfs
  describe EntriesController do

    def valid_attributes
      Fabricate.attributes_for :entry
    end

    let(:entry) { Fabricate :entry }
    alias :create_entry :entry

    describe "GET index" do
      it "assigns all entries as @entries" do
        create_entry
        get :index
        assigns(:entries).should include entry
      end
    end

    describe "GET show" do
      it "assigns the requested entry as @entry" do
        create_entry
        get :show, :id => entry.id.to_s
        assigns(:entry).should eq(entry)
      end
    end

    describe "GET new" do
      it "assigns a new entry as @entry" do
        get :new
        assigns(:entry).should be_a_new(Entry)
      end
    end

    describe "GET edit" do
      it "assigns the requested entry as @entry" do
        create_entry
        get :edit, :id => entry.id.to_s
        assigns(:entry).should eq(entry)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it { expect { post :create, :entry => valid_attributes }.to change(Entry, :count).by(1) }

        it "assigns a newly created entry as @entry" do
          post :create, :entry => valid_attributes
          assigns(:entry).should be_a(Entry)
          assigns(:entry).should be_persisted
        end

        it "redirects to the created entry" do
          post :create, :entry => valid_attributes
          response.should redirect_to(Entry.last)
        end
      end

      describe "with invalid params" do
        before { Entry.any_instance.stub(:save).and_return(false) }
        it "assigns a newly created but unsaved entry as @entry" do
          post :create, :entry => {}
          assigns(:entry).should be_a_new(Entry)
        end

        it "re-renders the 'new' template" do
          post :create, :entry => {}
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        before { create_entry }
        it "updates the requested entry" do
          Entry.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, :id => entry.id, :entry => {'these' => 'params'}
        end

        it "assigns the requested entry as @entry" do
          put :update, :id => entry.id, :entry => valid_attributes
          assigns(:entry).should eq(entry)
        end

        it "redirects to the entry" do
          put :update, :id => entry.id, :entry => valid_attributes
          response.should redirect_to(entry)
        end
      end

      describe "with invalid params" do
        before { create_entry }
        before { Entry.any_instance.stub(:save).and_return(false) }

        it "assigns the entry as @entry" do
          put :update, :id => entry.id.to_s, :entry => {}
          assigns(:entry).should eq(entry)
        end

        it "re-renders the 'edit' template" do
          put :update, :id => entry.id.to_s, :entry => {}
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      before { create_entry }
      it "destroys the requested entry" do
        expect { delete :destroy, :id => entry.id.to_s }.to change(Entry, :count).by(-1)
      end

      it "redirects to the entries list" do
        delete :destroy, :id => entry.id.to_s
        response.should redirect_to(entries_path)
      end
    end

  end
end
