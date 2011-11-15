module ElVfs
  class Entry < ActiveRecord::Base
    validates_presence_of :entry_name
    has_ancestry
    before_save :set_entry_uid
    before_save :set_entry_uid_hash

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
          :hash => entry_uid_hash,
          :url  => ::Rails.application.routes.url_helpers.entry_url(self, ::Rails.application.config.action_mailer[:default_url_options])
        }
      end

      def relative_entry_uid
        entry_uid[1..-1] || ''
      end

      def set_entry_uid
        self.entry_uid = [parent.try(:entry_uid), entry_name].compact.join('/')
      end

      def set_entry_uid_hash
        self.entry_uid_hash = Base64.urlsafe_encode64(relative_entry_uid).strip.tr '=', ''
      end
  end
end
