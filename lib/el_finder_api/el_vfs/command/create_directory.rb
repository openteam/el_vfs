module ElVfs
  class Command::CreateDirectory < ElVfs::Command
    register_in_connector :mkdir
    class Arguments < Command::Arguments
      attr_accessor :target, :name
      validates_presence_of :target, :name
      validates :entry, :is_a_directory => true
    end

    class Result < Model
      attr_accessor :arguments
      delegate :entry, :to => :arguments

      def added
        [ Directory.create!(:parent => entry, :entry_name => arguments.name) ]
      end

      def el_hash
        { added: added }
      end
    end
  end
end
