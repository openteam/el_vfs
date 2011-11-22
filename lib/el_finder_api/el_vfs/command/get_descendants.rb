module ElVfs
  class Command::GetDescendants < ElVfs::Command
    register_in_connector :tree

    class Arguments < Command::Arguments
      attr_accessor :target

      validates_presence_of :target
      validates :entry, :is_a_directory => true
    end

    class Result < Model
      attr_accessor :arguments
      delegate :entry, :to => :arguments

      def tree
        entry.descendants(:to_depth => 2)
      end

      def el_hash
        {tree: tree}
      end
    end

    protected
      def execute_command
        self.result = Result.new(:arguments => arguments)
      end


  end
end
