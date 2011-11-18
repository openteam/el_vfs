module ElVfs
  class Command::DuplicateEntries < ElVfs::Command
    register_in_connector :duplicate

    options :targets

    protected

      def hash
        if targets && entries.any? && entries.all?
          { :added => duplicate_entries }
        else
          wrong_params_hash
        end
      end

    private

      def entries
        @entries ||= targets.map{|target| Entry.find_by_entry_path_hash(target)}
      end

      def duplicate_entries
        entries.map(&:duplicate)
      end
  end
end
