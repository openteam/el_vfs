module ElVfs
  class Command::GetAncestors < ElVfs::Command
    register_in_connector :parents

    class Arguments < Command::Arguments
      attr_accessor :target
      validates_presence_of :target
      validates :entry, :is_a_directory => true
    end

    class Result < Model
      attr_accessor :arguments
      delegate :entry, :to => :arguments

      def tree
        [entry.ancestors + entry.ancestors.from_depth(1).map(&:directories) + [entry]].flatten.uniq
      end

      def el_hash
        {tree: tree}
      end
    end

  end
end
