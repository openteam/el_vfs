module ElVfs
  class Command::DestroyEntries < ElVfs::Command
    register_in_connector :rm

    options :targets

    protected

    def hash
      if targets && entries.any? && entries.all?
        { :removed => entries.map(&:destroy) }
      else
        wrong_params_hash
      end
    end

    private

    def entries
      @entries ||= [*targets].map{|hash| Entry.find_by_entry_path_hash(hash)}
    end

  end
end
