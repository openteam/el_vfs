module ElVfs
  class Entry < ActiveRecord::Base
    validates_presence_of :name
    has_ancestry
    before_save :set_entry_path
    before_save :set_hash

    def self.root
      Directory.find_or_initialize_by_name('').tap do | root |
        root.save! :validate => false
      end
    end

    def permissions
      {}
    end

    private
      def set_entry_path
        self.entry_path = is_root? ? '/' : [parent.entry_path, name].join('/').gsub(%r{^//}, '/')
      end

      def set_hash
        self.hash = Base64.encode64(entry_path).gsub(/\s/, '')
      end
  end
end
