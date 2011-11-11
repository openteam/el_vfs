module Vfs
  class Entry < ActiveRecord::Base
    validates_presence_of :name

    def self.root
      Folder.find_or_create_by_name '/'
    end
  end
end
