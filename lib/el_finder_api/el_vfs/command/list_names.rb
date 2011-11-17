class ElVfs::Command::ListNames < ElVfs::Command
  register_in_connector :ls
  options :target

  protected

    def hash
      if target
        { list: directory.files.map(&:entry_name) }
      else
        wrong_params_hash
      end
    end
end
