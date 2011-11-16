class ElVfs::Command::GetAncestors < ElVfs::Command
  register_in_connector :parents

  options :target

  protected

    def hash
      if target
        { :tree => directory.ancestors }
      else
        wrong_params_hash
      end
    end
end
