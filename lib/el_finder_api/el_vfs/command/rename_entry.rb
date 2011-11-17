module ElVfs
  class Command::RenameEntry < ElVfs::Command
    register_in_connector :rename
    options :target, :name

    protected
      def hash
        if target && name
          entry.update_attributes! :entry_name => name
          { added: [ entry ], :removed => [target] }
        else
          wrong_params_hash
        end
      end
  end
end
