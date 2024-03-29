module ElVfs
  class Command::GetAncestors < ElVfs::Command
    register_in_connector :parents

    class Arguments < Command::Arguments
      attr_accessor :target
      validates_presence_of :target
      validates :entry, :is_a_directory => true
    end

    class Result < Command::Result
      def tree
        tree = arguments.entry.ancestors
        tree += arguments.entry.ancestors.from_depth(1).map(&:directories).flatten
        tree << arguments.entry
        tree += Entry.where(['ancestry_depth <= ?', 2]).only_directories
        tree.uniq
      end
    end

  end
end
