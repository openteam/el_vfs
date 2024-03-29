module ElVfs

  class ::IsAFileValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must be an instance of ElVfs::File (was #{value.class})" unless value.is_a?(ElVfs::File)
    end
  end

  class ::IsADirectoryValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must be an instance of ElVfs::Directory (was #{value.class})" unless value.is_a?(ElVfs::Directory) || value.is_a?(ElVfs::Root)
    end
  end

  class ::IsAnEntryValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      record.errors[attribute] << "must be an instance of ElVfs::Entry (was #{value.class})" unless value.is_a?(ElVfs::Entry)
    end
  end

  class Command < Model

    attr_accessor :arguments, :error, :result

    class Arguments < Model
      def entry
        @entry ||= Entry.find_by_entry_path_hash target
      end
      def entries
        @entries ||= targets.map{|target| Entry.find_by_entry_path_hash target}
      end
    end

    class Result < Model
      attr_accessor :arguments, :execute_command
    end

    class_attribute :command_name

    class Error < Model
      attr_accessor :error
    end

    def initialize(init_params)
      self.arguments = "#{self.class.name}::Arguments".constantize.new(init_params)
    end

    def run
      self.result = "#{self.class.name}::Result".constantize.new(:arguments => arguments, :execute_command => execute_command)
    end

    def headers
      @headers ||= {}
    end

    protected

      def execute_command
      end

      def self.register_in_connector(command_name=nil)
        self.command_name = command_name || name.demodulize.underscore
        Connector.commands[self.command_name] = self
      end
  end
end
