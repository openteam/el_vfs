module ElVfs
  class File < Entry

    def entry_uid
      entry_path
    end

    def entry_uid=(uid)
      self.entry_path=(uid)
    end

    file_accessor :entry

    protected

      def relative_entry_path
        entry_path[root.entry_path.length..-1]
      end

      def set_entry_path
        self.entry_path = "#{parent.entry_path}#{entry_name}"
      end
  end
end
