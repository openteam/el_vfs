module ElVfs

  class Command::ChangeWorkingDirectory < Command
    register_in_connector :open
    options :init, :target, :tree

    def hash
      if init
        self.target ||= Entry.root.entry_uid_hash
        {:api => 2, :cwd => directory.el_hash, :files => files, :options => []}
      elsif target
        {:cwd => directory.el_hash, :files => files}
      else
        wrong_params_hash
      end
    end

    private

      def files
        @files ||= begin
                     files = directory.children.only_files
                     if tree
                       files << Entry.root
                       files += Entry.root.subtree(:to_depth => 2).only_directories
                     end
                     files.map!(&:el_hash)
                   end
      end

      def directory
        @directory ||= Directory.find_by_entry_uid_hash target
      end
  end

end
