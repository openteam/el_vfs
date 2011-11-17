module ElVfs
  class Command::CreateDirectory < ElVfs::Command
    register_in_connector :mkdir
    options :target, :name

    protected
      def hash
        if target && name
          { added: [ Directory.create!(:parent => directory, :entry_name => name) ] }
        else
          wrong_params_hash
        end
      end
  end
end
