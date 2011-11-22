module ElVfs
  class Command::CreateDirectory < ElVfs::Command
    register_in_connector :mkdir
    class Arguments < Command::Arguments
      attr_accessor :target, :name
      validates_presence_of :target, :name
      validates :entry, :is_a_directory => true
    end

    class Result < Command::Result
      def added
        [ Directory.create!(:parent => arguments.entry, :entry_name => arguments.name) ]
      end
    end
  end
end
