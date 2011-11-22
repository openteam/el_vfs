module ElVfs
  class ElFinderController < ApplicationController
    respond_to :json, :html

    def run
      result = Connector.new.run(params)
      respond_to do | format |
        format.html { render :json => result.el_hash }
        format.json { render :json => result.el_hash }
      end
    end
  end

end
