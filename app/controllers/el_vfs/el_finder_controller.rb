module ElVfs
  class ElFinderController < ApplicationController
    respond_to :json, :xml

    def run
      respond_with Connector.new.execute(params).el_hash
    end
  end

end
