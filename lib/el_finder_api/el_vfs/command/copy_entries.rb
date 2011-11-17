module ElVfs
  class Command::CopyEntries < ElVfs::Command
    register_in_connector :paste

    options :src, :dst, :targets, :cut


    protected
      def hash
        if source && destination && entries.any? && entries.all?
          {:added => copy_entries, :removed => removed_entries.map(&:target)}
        else
          wrong_params_hash
        end
      end

    private
      def removed_entries
        cut ? entries.map(&:destroy) : []
      end

      def copy_entries
        entries.map do | entry |
          entry.dup.tap do | entry |
            entry.update_attributes! :parent => destination
          end
        end
      end

      def source
        @source ||= Entry.only_directories.find_by_entry_path_hash(src)
      end

      def destination
        @destination ||= Entry.only_directories.find_by_entry_path_hash(dst)
      end

      def entries
        @entries ||= [*targets].map{|hash| source.children.find_by_entry_path_hash(hash)}
      end
  end
end
