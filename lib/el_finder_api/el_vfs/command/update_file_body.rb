module ElVfs
  class Command::UpdateFileBody < Command
    register_in_connector :put

    class Arguments < Command::Arguments
      attr_accessor :target, :content
      validates_presence_of :target, :content
      validates :entry, :is_a_file => true
    end

    class Result < Command::Result
      def added
        [execute_command]
      end
    end

    protected

      def execute_command
        Dir.mktmpdir do |dir|
          content_file =  ::File.open("#{dir}/#{arguments.entry.entry_name}", "w"){|f|f.write(arguments.content)}
          arguments.entry.entry = ::File.open("#{dir}/#{arguments.entry.entry_name}")
        end
        arguments.entry
      end

  end
end
