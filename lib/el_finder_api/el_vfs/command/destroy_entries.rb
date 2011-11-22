module ElVfs
  class Command::DestroyEntries < ElVfs::Command
    register_in_connector :rm

    class Arguments < Command::Arguments
      attr_accessor :targets
      validates_presence_of :targets
      validates :entries, :is_an_entry => true
    end

    class Result < Command::Result
      def removed
        arguments.targets
      end
    end

    protected

      def execute_command
        arguments.entries.map(&:destroy)
      end

  end
end
