class ElVfs::Command::ReadFileBody < ElVfs::Command
  register_in_connector :get

  options :target

  protected

    def hash
      if target && file
        { :content => file.entry.data }
      else
        wrong_params_hash
      end
    end
end
