module ElVfs
  class Directory < Entry
    default_values :entry_mime_type => 'directory', :entry_size => 0

    def directories
      children.only_directories
    end

    def files
      children.only_files
    end

  end
end
