module Vfs
  class FilesController < ApplicationController
    # GET /files
    # GET /files.json
    def index
      @files = File.all
  
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @files }
      end
    end
  
    # GET /files/1
    # GET /files/1.json
    def show
      @file = File.find(params[:id])
  
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @file }
      end
    end
  
    # GET /files/new
    # GET /files/new.json
    def new
      @file = File.new
  
      respond_to do |format|
        format.html # new.html.erb
        format.json { render json: @file }
      end
    end
  
    # GET /files/1/edit
    def edit
      @file = File.find(params[:id])
    end
  
    # POST /files
    # POST /files.json
    def create
      @file = File.new(params[:file])
  
      respond_to do |format|
        if @file.save
          format.html { redirect_to @file, notice: 'File was successfully created.' }
          format.json { render json: @file, status: :created, location: @file }
        else
          format.html { render action: "new" }
          format.json { render json: @file.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # PUT /files/1
    # PUT /files/1.json
    def update
      @file = File.find(params[:id])
  
      respond_to do |format|
        if @file.update_attributes(params[:file])
          format.html { redirect_to @file, notice: 'File was successfully updated.' }
          format.json { head :ok }
        else
          format.html { render action: "edit" }
          format.json { render json: @file.errors, status: :unprocessable_entity }
        end
      end
    end
  
    # DELETE /files/1
    # DELETE /files/1.json
    def destroy
      @file = File.find(params[:id])
      @file.destroy
  
      respond_to do |format|
        format.html { redirect_to files_url }
        format.json { head :ok }
      end
    end
  end
end
