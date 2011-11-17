module ElVfs
  class Command::CreateFile < ElVfs::Command
    register_in_connector :mkfile
    options :target, :name

    protected
      def hash
        if target && name
          fs_directory = Dir.mktmpdir
          begin
            vfs_file = ElVfs::File.create :parent => directory, :entry => ::File.open("#{fs_directory}/#{name}", "w")
          ensure
            FileUtils.remove_entry_secure fs_directory
          end
          { added: [ vfs_file ] }
        else
          wrong_params_hash
        end
      end
  end
end
