module ElVfs
  class Entry < ActiveRecord::Base
    validates_presence_of :entry_name
    has_ancestry :cache_depth => true
    before_save :set_entry_path
    before_save :set_entry_path_hash

    scope :only_files, where("type not in ('ElVfs::Directory', 'ElVfs::Root')")
    scope :only_directories, where(:type => ['ElVfs::Directory', 'ElVfs::Root'])

    delegate :entry_path_hash, :to => :parent, :allow_nil => true, :prefix => true

    def directories
      children.only_directories
    end

    def files
      children.only_files
    end

    def self.root
      Root.find_or_create_by_entry_name('root')
    end

    def el_hash
      el_entry.merge(el_permissions)
    end

    def target
      entry_path_hash
    end

    def duplicate
      Entry.transaction do
        dup.tap do | entry |
          entry.update_attributes! :entry_name => entry.duplicate_name
          self.copy_descendants_to(entry)
        end
      end
    end

    protected
      def copy_descendants_to(entry)
        self.children.each do |child|
          child_copy = child.dup
          child_copy.update_attributes! :parent => entry
          child.copy_descendants_to(child_copy)
        end
      end

      def duplicate_name
        i = 0
        begin i += 1 end while parent.children.find_by_entry_name(name_of_copy(i))
        name_of_copy(i)
      end

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
          :hash => entry_path_hash,
          :phash => parent_entry_path_hash.to_s,
          :url  => ::Rails.application.routes.url_helpers.entry_url(self, ::Rails.application.config.action_mailer[:default_url_options])
        }
      end

      def set_entry_path_hash
        self.entry_path_hash = "#{root.root_name}_#{Base64.urlsafe_encode64(relative_entry_path).strip.tr('=', '')}"
      end
  end
end
