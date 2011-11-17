module ElVfs
  class File < Entry

    def entry_uid
      entry_path
    end

    def entry_uid=(uid)
      self.entry_path=(uid)
    end

    def duplicate
      dup.tap do | entry |
        entry.update_attributes! :entry_name => entry.duplicate_name
      end
    end


    file_accessor :entry

    protected
      def ext_entry_name
        ::File.extname entry_name
      end

      def base_entry_name
        ::File.basename entry_name, ext_entry_name
      end

      def duplicate_name
        "#{base_entry_name} copy1#{ext_entry_name}"
      end

      def relative_entry_path
        entry_path[root.entry_path.length..-1]
      end

      def set_entry_path
        self.entry_path = "#{parent.entry_path}#{entry_name}"
      end
  end
end
