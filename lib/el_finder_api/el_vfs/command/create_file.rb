module ElVfs
  class Command::CreateFile < ElVfs::Command
    register_in_connector :mkfile

    class Arguments < Command::Arguments
      attr_accessor :target, :name
      validates_presence_of :target, :name
      validates :entry, :is_a_directory => true
    end

    class Result < Command::Result
      def added
        [
          ElVfs::File.new(:parent => arguments.entry).tap do | file |
            Dir.mktmpdir{|dir| file.entry = ::File.open("#{dir}/#{arguments.name}", "w") }
            file.save!
          end
        ]
      end
    end
  end
end
