module ElVfs

  class Command::ChangeWorkingDirectory < Command
    register_in_connector :open

    class Arguments < Command::Arguments
      attr_accessor :init, :target, :tree

      validates_presence_of :init, :unless => :target
      validates :entry, :is_a_directory => true

      def initialize(params)
        super
        self.target ||= Entry.root.target if init
      end
    end

    class Result < Command::Result
      def api;        2               end
      def cwd;        arguments.entry end
      def uplMaxSize; '16m'           end

      def files
        entries = arguments.entry.children.all
        entries += Entry.where(['ancestry_depth <= ?', 2]).only_directories.order(:ancestry_depth) if arguments.tree
        entries.uniq
      end


      def options
        {path: arguments.entry.el_vfs_path, url: arguments.entry.url, disabled: [], separator: '/', copyOverwrite: 1, archivers: {create: [], extract: []}}
      end
    end

  end

end
