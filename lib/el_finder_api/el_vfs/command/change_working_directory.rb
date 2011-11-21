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

    class Result < Model
      attr_accessor :arguments
      delegate :entry, :tree, :init, :to => :arguments

      def api
        2
      end

      def cwd
        entry
      end

      def files
        entries = entry.files.all
        entries += Entry.where(['ancestry_depth <= ?', 2]).only_directories.order(:ancestry_depth) if tree
        entries
      end

      def uplMaxSize
        '16m'
      end

      def options
        {path: entry.el_vfs_path, url: entry.url, disabled: [], separator: '/', copyOverwrite: 1, archivers: {create: [], extract: []}}
      end

      def el_hash
        {api: api, cwd: cwd, files: files, uplMaxSize: uplMaxSize, options: options}.with_indifferent_access
      end
    end

    protected
      def execute_command
        self.result = Result.new(:arguments => arguments)
      end


  end

end
