module ElVfs

  class Command::ChangeWorkingDirectory < Command
    register_in_connector :open
    options :init, :target, :tree

    def hash
      if init
        self.target ||= Entry.root.entry_path_hash
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
                     files = []
                     files += Entry.where(['ancestry_depth <= ?', 2]).only_directories.order(:ancestry_depth) if tree
                     files += directory.children.only_files
                     files.map!(&:el_hash)
                   end
      end

  end

end
