module ElVfs
  class Command::RenameEntry < ElVfs::Command
    register_in_connector :rename

    class Arguments < Command::Arguments
      attr_accessor :target, :name
      validates_presence_of :target, :name
      validates :entry, :is_an_entry => true
    end

    class Result < Command::Result
      def added
        [arguments.entry]
      end
      def removed
        [arguments.target]
      end
    end

    protected
      def execute_command
        arguments.entry.update_attributes! :entry_name => arguments.name
      end
  end
end
