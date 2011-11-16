module ElVfs
  class Directory < Entry
    default_values :entry_mime_type => 'directory', :entry_size => 0

    def directories
      children.only_directories
    end

    def files
      children.only_files
    end

    protected

      def el_entry
        super.tap do | hash |
          hash[:dirs] = directories.any? ? 1 : 0
        end
      end
  end
end
