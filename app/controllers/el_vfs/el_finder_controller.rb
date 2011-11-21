module ElVfs
  class ElFinderController < ApplicationController
    respond_to :json, :xml

    def run
      respond_with Connector.new.execute(params)
    end
  end

end
