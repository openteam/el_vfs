module ElVfs
  class Entry < ActiveRecord::Base
    validates_presence_of :entry_name
    has_ancestry
    before_save :set_entry_uid

    def self.root
      Directory.find_or_initialize_by_entry_name('').tap do | root |
        root.save! :validate => false
      end
    end

    def el_json
      el_entry.merge(el_permissions).to_json
    end

    private

      def el_permissions
        {
          :read => true,
          :write => true,
          :rm => true
        }
      end

      def el_entry
        {
          :name => entry_name,
          :mime => entry_mime_type,
          :date => I18n.l(updated_at),
          :size => entry_size,
          :hash => entry_uid
        }
      end

      def set_entry_uid
        self.entry_uid = [parent.try(:entry_uid), entry_name].compact.join('/')
      end
  end
end
