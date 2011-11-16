module ElVfs
  class Entry < ActiveRecord::Base
    validates_presence_of :entry_name
    has_ancestry :cache_depth => true
    before_save :set_entry_uid
    before_save :set_entry_uid_hash

    scope :only_files, where(['type <> ?', 'ElVfs::Directory'])
    scope :only_directories, where(:type => 'ElVfs::Directory')

    delegate :entry_uid_hash, :to => :parent, :allow_nil => true, :prefix => true

    def self.root
      Directory.find_or_initialize_by_entry_name('').tap do | root |
        root.save! :validate => false
      end
    end

    def el_hash
      el_entry.merge(el_permissions)
    end

    private

      def el_permissions
        {
          :read => 1,
          :write => 1,
          :locked => 0
        }
      end

      def el_entry
        {
          :name => entry_name,
          :mime => entry_mime_type,
          :date => I18n.l(updated_at),
          :size => entry_size,
          :hash => entry_uid_hash,
          :phash => parent_entry_uid_hash.to_s,
          :url  => ::Rails.application.routes.url_helpers.entry_url(self, ::Rails.application.config.action_mailer[:default_url_options])
        }
      end

      def relative_entry_uid
        is_root? ? '/' : entry_uid[1..-1] || ''
      end

      def set_entry_uid
        self.entry_uid =  depth > 1 ? "#{parent.entry_uid}/#{entry_name}" : "/#{entry_name}"
      end

      def set_entry_uid_hash
        self.entry_uid_hash = "l0_#{Base64.urlsafe_encode64(relative_entry_uid).strip.tr('=', '')}"
      end
  end
end
