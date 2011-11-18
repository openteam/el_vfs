class ElVfs::Command::GetAncestors < ElVfs::Command
  register_in_connector :parents

  options :target

  protected

    def hash
      if target
        { :tree => get_ancestors }
      else
        wrong_params_hash
      end
    end

  private

    def get_ancestors
      [directory.ancestors + directory.ancestors.from_depth(1).map(&:directories) + [directory]].flatten.uniq
    end
end
