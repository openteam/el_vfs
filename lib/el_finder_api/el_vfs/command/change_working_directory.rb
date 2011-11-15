module ElVfs

  class Command::ChangeWorkingDirectory < Command
    register_in_connector :open
    options :init, :target

    def result
      if init
        self.target ||= Entry.root.entry_uid_hash
        {:api => 2, :cwd => directory.el_hash, :files => [], :options => []}
      elsif target
        { :cwd => directory.el_hash, :files => [] }
      else
        super
      end
    end

    private

      def directory
        @directory ||= Directory.find_by_entry_uid_hash target
      end
  end

end
