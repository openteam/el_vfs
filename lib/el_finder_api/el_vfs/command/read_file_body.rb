module ElVfs
  class Command::ReadFileBody < ElVfs::Command
    register_in_connector :get

    class Arguments < Command::Arguments
      attr_accessor :target
      validates_presence_of :target
      validates :entry, :is_a_file => true
    end

    class Result < Command::Result
      def content
        arguments.entry.entry.data
      end
    end
  end
end
