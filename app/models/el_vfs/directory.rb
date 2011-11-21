module ElVfs
  class Directory < Entry
    default_values :entry_mime_type => 'directory', :entry_size => 0

    def el_vfs_path
      "#{parent.el_vfs_path}/#{entry_name}"
    end

    protected

      def name_of_copy(number)
        "#{entry_name} copy#{number}"
      end

      def relative_entry_path
        entry_path[root.entry_path.length..-2]
      end

      def el_entry
        super.tap do | hash |
          hash[:dirs] = directories.any? ? 1 : 0
        end
      end

      def set_entry_path
        self.entry_path = "#{parent.entry_path}#{entry_name}/"
      end

  end
end
