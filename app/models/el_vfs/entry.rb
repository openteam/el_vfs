module ElVfs
  class Entry < ActiveRecord::Base
    validates_presence_of :name
    has_ancestry
    before_save :set_hash

    def self.root
      Folder.find_or_create_by_name '/'
    end

    def path
      name
    end

    def permissions
      {}
    end

    private
      def set_hash
        self.hash = Base64.encode64(path).squish
      end
  end
end
