module ElVfs
  class ElFinderController < ApplicationController
    respond_to :json, :html

    def run
      command = Connector.new.command_for(params)
      command.run
      command.headers.each { |h,v| headers[h] = v }
      json = command.result.try(:el_hash)
      respond_to do | format |
        format.html { render :json => json }
        format.json { render :json => json }
      end
    end
  end

end
