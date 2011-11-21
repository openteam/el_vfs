module ElVfs
  class Root < Entry
    default_values :entry_mime_type => 'directory', :entry_size => 0
    scope :ordered, order(:root_number)

    def root_name
      ['r', root_number].join
    end

    def el_vfs_path
      entry_name
    end

    protected
      def relative_entry_path
        '/'
      end

      def el_entry
        super.tap do | hash |
          hash[:dirs] = directories.any? ? 1 : 0
          hash[:volumeid] = "#{root_name}_"
        end
      end

      def set_root_number
        self.root_number = Root.ordered.last.try(:root_number).to_i + 1
      end

      def set_entry_path
        set_root_number
        self.entry_path = "r#{root_number}/"
      end

  end
end
