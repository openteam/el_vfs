module ElVfs
  class File < Entry
    file_accessor :entry

    def entry_uid
      entry_path
    end

    def entry_uid=(uid)
      self.entry_path=(uid)
    end

    protected
      def ext_entry_name
        ::File.extname entry_name
      end

      def base_entry_name
        ::File.basename entry_name, ext_entry_name
      end

      def name_of_copy(number)
        "#{base_entry_name} copy#{number}#{ext_entry_name}"
      end

      def relative_entry_path
        entry_path[root.entry_path.length..-1]
      end

      def set_entry_path
        self.entry_path = "#{parent.entry_path}#{entry_name}"
      end

  end
end
