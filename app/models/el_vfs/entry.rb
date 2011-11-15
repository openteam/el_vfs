module ElVfs
  class Entry < ActiveRecord::Base
    validates_presence_of :file_name
    has_ancestry
    before_save :set_file_uid

    def self.root
      Directory.find_or_initialize_by_file_name('').tap do | root |
        root.save! :validate => false
      end
    end

    def permissions
      { :read => true, :write => true, :rm => true }
    end

    def el_json
      ({:name => file_name, :mime => file_mime_type, :date => I18n.l(updated_at), :size => file_size, :hash => file_uid}.merge(permissions).to_json)
    end

    private
      def set_file_uid
        self.file_uid = is_root? ? '/' : [parent.file_uid, file_name].join('/').gsub(%r{^//}, '/')
      end
  end
end
