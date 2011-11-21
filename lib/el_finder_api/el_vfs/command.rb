module ElVfs

  class ::IsADirectoryValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must be an instance of ElVfs::Directory (was #{value.class})" unless value.is_a?(ElVfs::Directory) || value.is_a?(ElVfs::Root)
    end
  end

  class Command < Model

    attr_accessor :arguments, :error, :result

    class Arguments < Model
      def entry
        Entry.find_by_entry_path_hash target
      end
    end

    class_attribute :command_name

    delegate :target, :to => :arguments

    class Error < Model
      attr_accessor :error
    end

    def initialize(init_params)
      self.arguments = "#{self.class.name}::Arguments".constantize.new(init_params)
    end

    def run
      if arguments.valid?
        execute_command
      else
        self.error = Error.new(:error => [:errCmdParams, command_name.to_sym])
      end
    end

    protected


      def self.register_in_connector(command_name=nil)
        self.command_name = command_name || name.demodulize.underscore
        Connector.commands[self.command_name] = self
      end

    private

      def validate_parameter_keys
        self.argument_error = (parameters.keys - self.class.options).any?
      end

  end
end
