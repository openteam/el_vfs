class ElVfs::Command::GetDescendants < ElVfs::Command
  options :target
  register_in_connector :tree

  protected
    def hash
      if target
        { :tree => directory.descendants(:to_depth => 2) }
      else
        wrong_params_hash
      end
    end
end
