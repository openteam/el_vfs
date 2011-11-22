module ElVfs
  class Command::CopyEntries < ElVfs::Command
    register_in_connector :paste

    class Arguments < Command::Arguments
      attr_accessor :targets, :src, :dst, :cut
      validates_presence_of :src, :dst, :targets

      validates :source, :destination, :is_a_directory => true
      validates :entries, :is_a_entry => true

      def cut?
        cut == '1' || cut == 'true' || cut == true
      end

      def source
        @source ||= Entry..find_by_entry_path_hash(src)
      end

      def destination
        @destination ||= Entry.find_by_entry_path_hash(dst)
      end
    end

    class Result < Command::Result
      def added
        execute_command
      end
      def removed
        arguments.cut? ? arguments.targets : []
      end
    end

    protected
      def execute_command
        arguments.entries.map do | entry |
          entry = entry.dup unless arguments.cut?
          entry.tap do | entry |
            entry.update_attributes! :parent => arguments.destination
          end
        end
      end
  end
end
